library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux3to1 is
  port(
    A : in std_logic_vector(31 downto 0);
    B : in std_logic_vector(31 downto 0);
    C : in std_logic_vector(31 downto 0);
    S : in std_logic_vector(1 downto 0);
    Y : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behav of mux3to1 is
  begin
    process(A,B,S)
      begin 
        if ( S = "00" ) then
          Y <= A;
        elsif( S="01" ) then 
          Y <= B;
        elsif(S="10" ) then 
          Y <= C; 
        end if;
    end process;
end architecture;


