library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for hex to seven-segment decoder
------------------------------------------------------------------------
entity hex_to_7seg is
port (
    hex_i : in  std_logic_vector(4-1 downto 0);
    seg_o : out std_logic_vector(8-1 downto 0)
);
end entity hex_to_7seg;

------------------------------------------------------------------------
-- Architecture declaration for hex to seven-segment decoder
------------------------------------------------------------------------
architecture Behavioral of hex_to_7seg is
begin

    --------------------------------------------------------------------
    --         a
    --       -----          a: seg_o(0)
    --    f |     | b       b: seg_o(1)
    --      |  g  |         c: seg_o(2)
    --       -----          d: seg_o(3)
    --    e |     | c       e: seg_o(4)
    --      |     |         f: seg_o(5)
    --       ----- . dp     g: seg_o(6)
    --         d				dp: seg_o(7)
    --------------------------------------------------------------------
	 ----dp,g,f,e,d,c,b,a
	 -- active level 1
	 seg_o <= "00111111" when (hex_i = "0000") else   -- 0
				 "00000110" when (hex_i = "0001") else   -- 1
				 "01011011" when (hex_i = "0010") else   -- 2
				 "01001111" when (hex_i = "0011") else   -- 3
				 "01100110" when (hex_i = "0100") else   -- 4
             "01101101" when (hex_i = "0101") else   -- 5
				 "01111101" when (hex_i = "0110") else   -- 6
				 "00000111" when (hex_i = "0111") else   -- 7
             "01111111" when (hex_i = "1000") else   -- 8
             "01101111" when (hex_i = "1001") else   -- 9
				 "00000000";


end architecture Behavioral;




