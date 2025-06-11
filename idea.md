# NeoVortex - herní koncept

NeoVortex je RTS strategie v Godotu, zasazená do otevřené galaxie, kde hráč ovládá kočky bojující o přežití a kontrolu.

## Hratelnost a mechaniky

* Hráč ovládá kočky, které se mohou volně pohybovat, lze je označit či zrušit označení.
* Kočky poráží nepřátelské kočky přiblížením se a zůstáním v jejich okolí po dobu několika sekund, za což získávají resource Čest.
* Čest je klíčová pro budování a rozšiřování armády.
* Za 5 jednotek Cti lze postavit kočičí domek, který generuje 10 jednotek resource Pamlsky.
* Pamlsky slouží k nákupu dalších koček ve speciální budově - bedně s kočkami (10 pamlsků za kočku).
* Kočičí miska je budova za 200 pamlsků, generuje resource Zoomies.
* Zoomies umožňují koupit dvě úrovně zrychlení pohybu jednotek (100 zoomies za 1. level, 200 za 2. level).
* Cílem hry je porazit Overlorda Cattuse, finálního bosse.

## Budovy a zdroje

* Kočičí domek: základní budova generující pamlsky.
* Bedna s kočkami: umožňuje spawnovat nové kočky.
* Kočičí miska: generuje zoomies pro vylepšení rychlosti.
* Rituální oltář: budova za 1000 pamlsků a 100 zoomies.
  * Zničí neproniknutelný štít Overlorda.
  * K aktivaci vyžaduje obětování všech dosavadních jednotek.

## Overlordův štít

* Overlord Cattus je chráněn štítem, který jej činí neproniknutelným.
* Dokud je štít aktivní, Overlord nepřijímá žádné poškození.
* Štít je viditelný pomocí speciálního progress baru.
* Zničení štítu je možné pouze pomocí rituálního oltáře.

## Další vlastnosti

* Náhodná generace nepřátelských koček po mapě.
* Ovládání kamery s možností pohybu a zoomu.
* Modely, animace a UI prvky jako HP bary a výběr jednotek.
* Strategické rozhodování, kdy a kde stavět a jak spravovat zdroje.