# Projekt Countdown
## Popis
Zadáním projektu bylo vytvořit countdown od nastavené číselné hodnoty zobrazené na 7-segmentovém displeji do nuly.

Nastavování žádané číselné hodnoty provádíme pomocí enkodéru KY-040 s tlačítkem. Maximální možná hodnota, kterou lze nastavit je 59:59 [min:sec]. 

Po zmáčknutí tlačítka, které je součástí enkodéru se začne od nastavené hodnoty odečítat do hodnoty 00:00. 
Rychlost odčítání je dána konstantou c_1sec v modulu countdown.
Pro zobrazování hodnoty na 7-segmenotvém displeji využíváme obvod TM1637, který využívá sériovou komunikaci. Sériovou komunikaci v modulu Display driver.

Pro zobrazení hodnoty je potřeba nejprve poslat příkaz k zapisování dat, poté příkaz k nastavení adresy, následně data dané hodnoty a nakoec příkaz na nastavení displeje.

K nastavení hodnoty je za potřebí sledovat pulzy vydávané enkodérem, díky kterým jsme schopni rozhodnout, zda-li je jím otáčeno a jaký směrem. O tuto problematiku se stará modul Encoder driver.

Na základě výsledků simulací jsme usoudili, že by náš kód mohl být funkční. Pro konečné ověření funkčnosti našeho kódu by bylo nejlepší toto zapojení realizovat. 


## Komponenty
[Countdown_top](https://github.com/xpokor79/Digital-electronics-1/blob/master/Labs/Projekt%20-%20Countdown/countdown/countdown_top.vhd)

[Countdown (modul)](https://github.com/xpokor79/Digital-electronics-1/blob/master/Labs/Projekt%20-%20Countdown/countdown/countdown.vhd)

[Encoder driver](https://github.com/xpokor79/Digital-electronics-1/blob/master/Labs/Projekt%20-%20Countdown/countdown/encoder_driver.vhd)

[Display driver](https://github.com/xpokor79/Digital-electronics-1/blob/master/Labs/Projekt%20-%20Countdown/countdown/display_driver2.vhd)

## Simlace + zapojení
### Zapojení countdown
![zapojeni_countdown](../Screens/top_schematic.png)
### Zapojení encoderu
![zapojeni_encoder](../Screens/encoder_schema.png)
### Simulace countdown top
![countdown_top_sim](../Screens/countdown_top_sim.png)
### Simulace countdown (modul)
![countdown_sim](../Screens/countdown_sim.png)
### Simulace encoder driver
![encoder_driver_sim](../Screens/encoder_driver_sim.png)
### Simulace display driver
![display_driver_sim](../Screens/display_driver_sim.png)

## Zdroje
[MT1637 datasheet](https://www.mcielectronics.cl/website_MCI/static/documents/Datasheet_TM1637.pdf)

[Encoder driver](https://docplayer.net/21051674-Rotary-encoder-interface-for-spartan-3e-starter-kit.html)
