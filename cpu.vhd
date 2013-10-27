library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpu is
	port(
		stateCpu : in std_logic;
		ins_in : in std_logic_vector(31 downto 0);
		address_in : in std_logic_vector(31 downto 0);
		data_in : in std_logic_vector(31 downto 0);
		address_out : out std_logic_vector(31 downto 0);
		data_out : out std_logic_vector(31 downto 0)
	);
end entity;


architecture behav of cpu is
type regs is array(31 downto 0) of std_logic_vector(31 downto 0);
signal auxReg : regs:= (others =>(others=>'0'));
signal opCode : std_logic_vector(5 downto 0);
signal funCode : std_logic_vector(5 downto 0);
begin
process( stateCpu, ins_in, address_in, data_in)
	variable dirRs : integer;
	variable dirRt : integer;
	variable dirRd : integer;
	variable auxImm : std_logic_vector(31 downto 0);
	variable auxBran : std_logic_vector(31 downto 0);
	begin
		opCode <= ins_in(31 downto 26);
		funCode <= ins_in(5 downto 0);
		dirRs := conv_integer(ins_in(25 downto 21));
		dirRt := conv_integer(ins_in(20 downto 16));
		dirRd := conv_integer(ins_in(15 downto 11));
		if ( stateCPU='0') then

			-- Add
			if ((ins_in(31 downto 26) = "000000") and (ins_in(5 downto 0) = "100000")) then
				auxReg(dirRd) <= auxReg(dirRs) + auxReg(dirRt);
			end if;

			-- Load
			if ins_in(31 downto 26) = "100011" then
				if (ins_in(15)='1') then
					auxImm := (others =>'1');
					auxImm(15 downto 0) := ins_in(15 downto 0);
				else
					auxImm := (others =>'0');
					auxImm(15 downto 0) := ins_in(15 downto 0);
				end if;
				address_out <= ( auxReg(conv_integer(ins_in(25 downto 21))) + auxImm);
			end if;

			-- Store
			if ins_in(31 downto 26) = "101011" then
				if (ins_in(15)='1') then
					auxImm(31 downto 0) := (others =>'1');
					auxImm(15 downto 0) := ins_in(15 downto 0);
				else
					auxImm(31 downto 0) := (others =>'0');
					auxImm(15 downto 0) := ins_in(15 downto 0);
				end if;
				data_out <= auxReg(conv_integer(ins_in(20 downto 16)));
				address_out <= (auxReg(conv_integer(ins_in(25 downto 21))) + auxImm);
			end if;
			
			-- Branch
			if ins_in(31 downto 26) = "000100" then
				if (ins_in(15)='1') then
					auxImm(31 downto 0) := (others =>'1');
					auxImm(15 downto 0) :=ins_in(15 downto 0);
				else
					auxImm(31 downto 0) := (others =>'0');
					auxImm(15 downto 0) := ins_in(15 downto 0);
				end if;
				auxBran(31 downto 2) := auxImm(29 downto 0);
				auxBran(1 downto 0) := "00";
				address_out <= ((address_in + "00000000000000000000000000000001") + auxBran);
			end if;
			
			-- Sll
			if ((ins_in(31 downto 26) = "000000") and (ins_in(5 downto 0) = "000000")) then
				auxReg(conv_integer(ins_in(15 downto 11))) <= (others =>'0');
				auxReg(conv_integer(ins_in(15 downto 11)))(31 downto conv_integer(ins_in(10 downto 6))) <= auxReg(conv_integer(ins_in(20 downto 16)))((31-conv_integer(ins_in 10 downto 6))) downto 0);
			end if;
			
			-- Nor
			if ((ins_in(31 downto 26) = "000000") and (ins_in(5 downto 0) = "010111")) then
				auxReg(conv_integer(ins_in(15 downto 11))) <= not( auxReg(conv_integer(ins_in(25 downto 21))) or auxReg(conv_integer(ins_in(20 downto 16))) );
			end if;

			
		end if;
		
		if(stateCPU='1') then
			case ins_in(31 downto 26) is
			when "000100" =>
				if (not(auxReg(conv_integer(ins_in(25 downto 21))) = auxReg(conv_integer(ins_in(20 downto 16))))) then
					address_out <= (address_in +"00000000000000000000000000000001");
				end if;
			when "100011" =>
				auxReg(dirRt) <= data_in;
				address_out <= (address_in +"00000000000000000000000000000001");
			when others => 
				address_out <= (address_in + "00000000000000000000000000000001");
			end case;
		end if;
		
	end process;
end architecture;