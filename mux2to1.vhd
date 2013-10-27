library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux2to1 is
  port(
    A : in std_logic_vector(31 downto 0 );
    B : in std_logic_vector(31 downto 0 );
    S : in std_logic;
    Y : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behav of mux2to1 is
  begin
    process(A,B,S)
      begin 
        if ( S = '1' ) then
          Y <= A;
        else
          Y <= B;
        end if;
    end process;
end architecture;


