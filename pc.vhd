library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity PC is
	port(
		IWrite : in std_logic;
		address_in : in std_logic_vector(31 downto 0);
		address_out: out std_logic_vector(31 downto 0)
	);
end entity;

Architecture behav of PC is
	begin
		process(IWrite, address_in)
			begin
				if IWrite = '1' then
					address_out <= address_in;
				end if;
		end process;
end architecture;