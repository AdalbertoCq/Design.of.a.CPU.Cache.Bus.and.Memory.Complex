library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity IR is
	port(
		IRWrite : in std_logic;
		ins_in : in std_logic_vector(31 downto 0);
		ins_out: out std_logic_vector(31 downto 0)
	);
end entity;


Architecture behav of IR is
	begin
		process(IRWrite, ins_in)
			begin
				if IRWrite = '1' then
					ins_out <= ins_in;
				end if;
		end process;
end architecture;