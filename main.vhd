library work;
use work.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity main is 
    port(
        rst    : in std_logic;
        IW_in  : in std_logic;
        crtl   : in std_logic;
        MW     : in std_logic;
        MWcrtl : in std_logic;
        stateC : in std_logic;
        stateCC: in std_logic;
        dataC  : in std_logic;
        insC   : in std_logic;
        sc     : in std_logic;
        pc_in  : in std_logic_vector( 31 downto 0);
        data   : in std_logic_vector( 31 downto 0);
        ins    : in std_logic_vector( 31 downto 0)
    );
end entity;

architecture structural of main is

    component cpu is
        port(
        stateCpu    : in  std_logic;
        ins_in      : in  std_logic_vector(31 downto 0);
        address_in  : in  std_logic_vector(31 downto 0);
        data_in     : in  std_logic_vector(31 downto 0);
        address_out : out std_logic_vector(31 downto 0);
        data_out    : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component Cache is 
        port(
        cacheType  : in  std_logic;                     -- Icahe=0; Dcache=1
        stateTrans : in  std_logic_vector(2 downto 0);
        address_in : in  std_logic_vector(31 downto 0);
        data_in    : in  std_logic_vector(31 downto 0);
        opType     : in  std_logic_vector(1 downto 0);
        data_out   : out std_logic_vector(31 downto 0);
        address_out: out std_logic_vector(31 downto 0);
        IHc        : out std_logic;
        DHc        : out std_logic;
        dbset      : out std_logic;
        trasn_out  : out std_logic
    );
    end component;
    
    component clock is 
        port( 
            clk : inout bit
        );
    end component;
    
    component IR is
        port(
        IRWrite        : in std_logic;
        ins_in : in  std_logic_vector(31 downto 0);
        ins_out: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component PC is 
        port(
        IWrite        : in std_logic;
        address_in : in  std_logic_vector(31 downto 0);
        address_out: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component mux3to1 is 
        port(
            A : in std_logic_vector(31 downto 0);
            B : in std_logic_vector(31 downto 0);
            C : in std_logic_vector(31 downto 0);
            S : in std_logic_vector(1 downto 0);
            Y : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component mux2to1 is 
        port(
            A : in std_logic_vector(31 downto 0);
            B : in std_logic_vector(31 downto 0);
            S : in std_logic;
            Y : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component Mem is 
        port(
        addressIn : in std_logic_vector(31 downto 0); --address Input 
        data_in : in std_logic_vector(31 downto 0);  
        MemRead : in std_logic;
        MemWrite : in std_logic;
        data_out : out std_logic_vector(31 downto 0)
        ); 
    end component;
    
    component fsm is 
        port(
        trasn_out : in std_logic;
        reset     : in std_logic;
        clock     : in bit;
        IHc       : in std_logic;
        DHc       : in std_logic;
        cadd      : in std_logic_vector(31 downto 0);
        ins       : in std_logic_vector(31 downto 0);
        pcc       : out std_logic_vector(1 downto 0 );
        ccm       : out std_logic;
        stateCPU  : out std_logic;
        IWrite    : out std_logic;
        IRWrite   : out std_logic;
        madd      : out std_logic_vector(31 downto 0);
        stateTrans: out std_logic_vector(2 downto 0);
        opType    : out std_logic_vector(1 downto 0);
        cacheType : out  std_logic;
        MemWrite  :out   std_logic;                                
        MemRead   :out    std_logic   
    );
    end component;
    
    component MUX1 is
        port(
            A : in std_logic;
            B : in std_logic;
            S : in std_logic;
            Y : out std_logic
        );
    end component;
    
    signal w0, w1, w2, w3,w4, w5, w7, w8, w9, w10, w11, w28, w29 : std_logic_vector(31 downto 0);
    signal w25, w21 : std_logic_vector(1 downto 0);
    signal w20 : std_logic_vector(2 downto 0);
    signal w13 : bit;
    signal w14, w15, w16, w17, w18, w19, w22, w23, w24, w26, w27, w30, w6, w31 : std_logic;
    
    begin
        
        cache1 : Cache   port map(w22, w20, w7, w10, w21, w4, w8, w14, w15, w30, w16 );
        mem1   : Mem     port map(w8, w4, w24, w27, w9);
        fsm1   : fsm     port map(w16, rst, w13, w14, w15, w1, w3, w25, w26, w17, w18, w19, w11, w20, w21, w22, w23, w24);
        cpu1   : cpu     port map(w31, w28, w1, w29, w0, w5);
        clk1   : clock   port map(w13);
        ir1    : IR      port map(w19, w4, w3);
        pc1    : PC      port map(w6, w2, w1);
        mux    : mux2to1 port map(w5, w9, w26, w10);
        mux2   : mux3to1 port map(w0, w1, w11, w25, w7);
        mux3   : mux2to1 port map(w0, pc_in, sc, w2);
        mux4   : MUX1    port map(w18, IW_in, crtl, w6);
        mux5   : MUX1    port map(w23, MW, MWcrtl, w27);
        mux6   : mux2to1 port map(w3, ins, insC, w28);
        mux7   : mux2to1 port map(w4, data, dataC, w29);
        mux8   : MUX1     port map(w17, stateC, stateCC, w31);
    
end structural;

    
        
        