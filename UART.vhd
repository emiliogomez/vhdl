--This is a possible solution for a parameterized UART following the next constraints:

-- Serial port (input) is '1' while standby, reception starts when detecting a 0 bit (start bit).
-- Data structure for each character is:
-- (8 OR 9) data bits, followed by 1 parity bit and (1 OR 2) stop bits. Data and stop bits might be customizable.
-- There will also be a parity selector (1 for odd, 0 for even), a syncronous reset signal, and two flags: RX_BUSY will be active
-- when the UART is reading data, activating VALID_DATA when there are no errors in the word (we must check for parity).

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY UART IS
  GENERIC (DATA_BITS: INTEGER:=8;
        STOP_BITS: INTEGER:=2);
  PORT (RX,CLK,RST,PARITY_SEL: IN STD_LOGIC;
        VALID_DATA: OUT STD_LOGIC;
        D_OUT: OUT STD_LOGIC_VECTOR(DATA_BITS-1 DOWNTO 0));
END ENTITY

ARCHITECTURE UART_ARCH OF UART IS
  SIGNAL RX_BUSY: STD_LOGIC;
BEGIN
  PROCESS(CLK,RST,RX)
    VARIABLE TMP: STD_LOGIC_VECTOR(DATA_BITS+STOP_BITS DOWNTO 0);
    VARIABLE COUNT: INTEGER RANGE TMP'RANGE;
    VARIABLE ONES: INTEGER RANGE TMP'REVERSE_RANGE;
  BEGIN
  IF CLK'EVENT AND CLK='1' THEN
    IF RST='1' THEN --reset must be synchronous
      D_OUT<=(OTHERS=>'X');
      TMP:=(OTHERS=>'X');
      VALID_DATA<='0';
    ELSIF RX_BUSY='0' THEN
      IF RX='0' THEN
        RX_BUSY<='1';
      ELSE
      --do nothing
      END IF;
    ELSE --that is: RX_BUSY='1' and not resetting
      IF COUNT>=STOP_BITS THEN
        TMP(COUNT):=RX;
        COUNT=COUNT-1;
        IF TMP(COUNT)='1' THEN
          ONES:=ONES+1;
        END IF;
      ELSE --all data has been saved, checking for parity and finishing sequence with the last 1 or 2 stop bits.
        IF COUNT=0 THEN
          IF ONES MOD 2 = PARITY_SEL THEN --i.e. if modulus op returns the desired parity sel when dividing number of ones by 2
            VALID_DATA<='1';
            D_OUT<=TMP(TMP'HIGH DOWNTO STOP_BITS+1); --in order to assign the only required data we have to cut this slice
          ELSE
            VALID_DATA<='0';
            D_OUT<=(OTHERS=>'X');
          END IF;
        --Setting everything up for the next sequence
        RX_BUSY<='0';
        COUNT:=COUNT'LEFT;
        ELSE --possible case when there are 2 stop_bits, we need one more iteration to get to count=0
        COUNT=COUNT-STOP_BITS+1;
        END IF;
      END IF;
    END IF;    
  END PROCESS;
END ARCHITECTURE;
