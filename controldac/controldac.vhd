library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity controldac is
  generic(
  	word_length:integer := 16;
	address_length:integer := 12);
  port (
	clk: in std_logic;
	addr: in std_logic_vector(31 downto 0);
	start: in std_logic:= '0';
	trigger, mode: in std_logic_vector(1 downto 0);
	length: in std_logic_vector(13 downto 0);
	repitition: in std_logic_vector(19 downto 0)) ;
end entity ; -- controldac

architecture synth of controldac is

  component outfifo is
	  generic (
	  	word_length:integer := 1;
	  	address_length:integer := 12);
	  port (
		init, clk: in std_logic;
		push, pop: in std_logic;
		full, empty: buffer std_logic;
		datain: in std_logic_vector(word_length-1 downto 0);
		dataout: out std_logic_vector(word_length-1 downto 0)
	  ) ;
  end component;

  component waveformBRAM is
    port (
	clk: in std_logic;
	wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
  end component;

  signal active, work_done, data00_loaded, init: std_logic:='0';
  signal setmode: std_logic_vector(1 downto 0);
  signal repitition_counter: std_logic_vector(19 downto 0) := (others => '0');

  signal push, pop: std_logic:='0';
  signal datain, dataout: std_logic_vector(0 downto 0); --Do we need dataout here?

  signal wea: STD_LOGIC_VECTOR(0 DOWNTO 0):="0";
  signal addra: STD_LOGIC_VECTOR(8 DOWNTO 0);
  signal dina: STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal douta: STD_LOGIC_VECTOR(15 DOWNTO 0);

  signal index: integer:=0;
  
  begin

  	outbuffer: outfifo	
  	port map(
	init => init,
  	clk => clk,
  	push => push,
  	pop => pop,
  	datain => datain,
  	dataout => dataout);

  	WFRAM: waveformBRAM
  	port map(
  	clk => clk,
  	wea => wea,
    addra => addra,
    dina => dina,
    douta => douta
  	);

	activate: process(clk) is
	begin
		if rising_edge(clk) then
			if (start = '1' and active = '0') then
				setmode <= mode;
				active <= '1';
			elsif (work_done = '1') then
				active <= '0';
			end if;
		end if;
	end process;

	execute: process(clk) is
	begin
		if (rising_edge(clk) and start = '1' and active = '1') then
			if (mode = "00") then
				if (data00_loaded = '1') then
					if (repitition_counter = repitition) then
						repitition_counter <= (others => '0');
						work_done <= '1';
					else
						work_done <= '0';
						if (index = word_length) then
							repitition_counter <= repitition_counter + 1;
							index <= 0;
							push <= '0';
						else
							push <= '1';
							datain(0) <= douta(index);
							index <= index + 1;
						end if;
					end if;
				else --load data from WFRAM
					wea <= "0";
					data00_loaded <= '1';
				end if;
			elsif (mode = "01") then
			elsif (mode = "10") then
			else
			end if;
		end if;
	end process;

	template: process(clk) is
	begin
		if (rising_edge(clk) and start = '1' and active = '0') then
			
		end if;
	end process;


end architecture ; -- synth