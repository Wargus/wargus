//   ___________		     _________		      _____  __
//   \_	  _____/______   ____   ____ \_   ___ \____________ _/ ____\/  |_
//    |    __) \_  __ \_/ __ \_/ __ \/    \  \/\_  __ \__  \\   __\\   __\ 
//    |     \   |  | \/\  ___/\  ___/\     \____|  | \// __ \|  |   |  |
//    \___  /   |__|    \___  >\___  >\______  /|__|  (____  /__|   |__|
//	  \/		    \/	   \/	     \/		   \/
//  ______________________                           ______________________
//			  T H E   W A R   B E G I N S
//   Utility for FreeCraft - A free fantasy real time strategy game engine
//	
/**@name wartool.c	-	Extract files from war archives. */
/*
**	(c) Copyright 1999-2000 by Lutz Sammer
**
**	$Id$
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>

#include <png.h>

#if !defined(__CYGWIN__) && !defined(__MINGW32__)
#define O_BINARY	0
#else
typedef unsigned long u_int32_t;
#endif

#include "myendian.h"

#undef main

//----------------------------------------------------------------------------
//	Config
//----------------------------------------------------------------------------

/* #define DIR	 "data" */
char *Dir = NULL;

/**
**	Path to the tileset graphics. (default=$DIR/graphic/tileset)
*/
#define TILESET_PATH	"graphic/tileset"

/**
**	Path to the unit graphics. (default=$DIR/graphic)
*/
#define UNIT_PATH	"graphic"

/**
**	Path the pud files. (default=$DIR)
*/
#define PUD_PATH	"."

/**
**	Path the font files. (default=$DIR/graphic)
*/
#define FONT_PATH	"graphic"

/**
**	Path the cursor files. (default=$DIR/graphic)
*/
#define CURSOR_PATH	"graphic"

/**
**	Path the graphic files. (default=$DIR/graphic)
*/
#define GRAPHIC_PATH	"graphic"

/**
**	Path the graphic files. (default=$DIR/graphic)
*/
#define GRAPHIC_PATH	"graphic"

/**
**	Path the sound files. (default=$DIR/sound)
*/
#define SOUND_PATH	"sound"

/**
**	Path the text files. (default=$DIR/text)
*/
#define TEXT_PATH	"text"

/**
**	How much tiles are stored in a row.
*/
#define TILE_PER_ROW	16

/**
**	Conversion control sturcture.
*/
typedef struct _control_ {
    int		Type;			/// Entry type
    int		Version;		/// Only in this version 
    char*	File;			/// Save file
    int		Arg1;			/// Extra argument 1
    int		Arg2;			/// Extra argument 2
    int		Arg3;			/// Extra argument 3
    int		Arg4;			/// Extra argument 4
} Control;

/**
**	Original archive buffer.
*/
unsigned char* ArchiveBuffer;

/**
**	Offsets for each entry into original archive buffer.
*/
unsigned char** ArchiveOffsets;

/**
**	Possible entry types of archive file.
*/
enum _archive_type_ {
    S,			// Setup
    F,			// File				(name)
    T,			// Tileset			(name,pal,mega,mini,map)
// FIXME: should be removed use from tileset
    R,			// RGB				(name,rgb)
    G,			// Graphics			(name,pal,gfx)
    U,			// Uncompressed Graphics	(name,pal,gfu)
    P,			// Pud				(name,idx)
    N,			// Font				(name,idx)
    I,			// Image			(name,pal,img)
    W,			// Wav				(name,wav)
    X,			// Text				(name,text)
    C,			// Cursor			(name,cursor)
};

/**
**	What, where, how to extract.
**
**	FIXME: version 1.00, 1.31, 1.40, 1.50 dependend!
*/
Control Todo[] = {

///////////////////////////////////////////////////////////////////////////////
//	TEXT	(must be done for all others!)
///////////////////////////////////////////////////////////////////////////////

{F,0,"strdat.war",				4000 },
{S,0,"unit_names",						  1	},
{X,0,"level01h",						 65	},
{X,0,"level01o",						 66	},
{X,0,"level02h",						 67	},
{X,0,"level02o",						 68	},
{X,0,"level03h",						 69	},
{X,0,"level03o",						 70	},
{X,0,"level04h",						 71	},
{X,0,"level04o",						 72	},
{X,0,"level05h",						 73	},
{X,0,"level05o",						 74	},
{X,0,"level06h",						 75	},
{X,0,"level06o",						 76	},
{X,0,"level07h",						 77	},
{X,0,"level07o",						 78	},
{X,0,"level08h",						 79	},
{X,0,"level08o",						 80	},
{X,0,"level09h",						 81	},
{X,0,"level09o",						 82	},
{X,0,"level10h",						 83	},
{X,0,"level10o",						 84	},
{X,0,"level11h",						 85	},
{X,0,"level11o",						 86	},
{X,0,"level12h",						 87	},
{X,0,"level12o",						 88	},
{X,0,"level13h",						 89	},
{X,0,"level13o",						 90	},
{X,0,"level14h",						 91	},
{X,0,"level14o",						 92	},

{X,2,"levelx01h",						 99	},
{X,2,"levelx01o",						100	},
{X,2,"levelx02h",						101	},
{X,2,"levelx02o",						102	},
{X,2,"levelx03h",						103	},
{X,2,"levelx03o",						104	},
{X,2,"levelx04h",						105	},
{X,2,"levelx04o",						106	},
{X,2,"levelx05h",						107	},
{X,2,"levelx05o",						108	},
{X,2,"levelx06h",						109	},
{X,2,"levelx06o",						110	},
{X,2,"levelx07h",						111	},
{X,2,"levelx07o",						112	},
{X,2,"levelx08h",						113	},
{X,2,"levelx08o",						114	},
{X,2,"levelx09h",						115	},
{X,2,"levelx09o",						116	},
{X,2,"levelx10h",						117	},
{X,2,"levelx10o",						118	},
{X,2,"levelx11h",						119	},
{X,2,"levelx11o",						120	},
{X,2,"levelx12h",						121	},
{X,2,"levelx12o",						122	},

///////////////////////////////////////////////////////////////////////////////
//	MOST THINGS
///////////////////////////////////////////////////////////////////////////////

{F,0,"maindat.war",				1000 },
{R,0,"summer",							 2	},
{T,0,"summer",					 2,	 3,	 4,	 5 },
{R,0,"wasteland",							10	},
{T,0,"wasteland",					10,	11,	12,	13 },
{R,0,"winter",							18	},
{T,0,"winter",					18,	19,	20,	21 },
{G,0,"dwarves",							 2,  33	},
{G,0,"goblin sapper",						 2,  34	},
{G,0,"gryphon rider",						 2,  35	},
{G,0,"dragon",							 2,  36	},
{G,0,"eye of kilrogg",						 2,  37	},
{G,0,"gnomish flying machine",					 2,  38	},
{G,0,"human transport",						 2,  39	},
{G,0,"orc transport",						 2,  40	},
{G,0,"battleship",						 2,  41	},
{G,0,"juggernaught",						 2,  42	},
{G,0,"gnomish submarine (summer,winter)",			 2,  43	},
{G,0,"giant turtle (summer,winter)",				 2,  44	},
#ifdef NEW_NAMES
{G,0,"human/units/%2",						 2,  45	},
{G,0,"orc/units/%3",						 2,  46	},
#else
{G,0,"%2",							 2,  45	},
{G,0,"%3",							 2,  46	},
#endif
{G,0,"peasant",							 2,  47	},
{G,0,"peon",							 2,  48	},
{G,0,"ballista",						 2,  49	},
{G,0,"catapult",						 2,  50	},
{G,0,"knight",							 2,  51	},
{G,0,"ogre",							 2,  52	},
{G,0,"archer",							 2,  53	},
{G,0,"axethrower",						 2,  54	},
{G,0,"mage",							 2,  55	},
{G,0,"death knight",						 2,  58	},
{G,0,"human tanker (empty)",					 2,  59	},
{G,0,"orc tanker (empty)",					 2,  60	},
{G,0,"elven destroyer",						 2,  61	},
{G,0,"troll destroyer",						 2,  62	},
{G,0,"goblin zeppelin",						 2,  63	},
{G,0,"critter (summer)",					 2,  64	},
{G,0,"critter (wasteland)",					10,  65	},
{G,0,"critter (winter)",					18,  66	},
{G,0,"skeleton",						 2,  69	},
{G,0,"daemon",							 2,  70	},
// 71-79 unknown
{G,0,"human guard tower (summer)",				 2,  80	},
{G,0,"orc guard tower (summer)",				 2,  81	},
{G,0,"human cannon tower (summer)",				 2,  82	},
{G,0,"orc cannon tower (summer)",				 2,  83	},
{G,0,"mage tower (summer)",					 2,  84	},
{G,0,"temple of the damned (summer)",				 2,  85	},
{G,0,"keep (summer)",						 2,  86	},
{G,0,"stronghold (summer)",					 2,  87	},
{G,0,"gryphon aviary (summer)",					 2,  88	},
{G,0,"dragon roost (summer)",					 2,  89	},
{G,0,"gnomish inventor (summer)",				 2,  90	},
{G,0,"goblin alchemist (summer)",				 2,  91	},
{G,0,"farm (summer)",						 2,  92	},
{G,0,"pig farm (summer)",					 2,  93	},
{G,0,"human barracks (summer)",					 2,  94	},
{G,0,"orc barracks (summer)",					 2,  95	},
{G,0,"church (summer)",						 2,  96	},
{G,0,"altar of storms (summer)",				 2,  97	},
{G,0,"human scout tower (summer)",				 2,  98	},
{G,0,"orc scout tower (summer)",				 2,  99	},
{G,0,"town hall (summer)",					 2, 100	},
{G,0,"great hall (summer)",					 2, 101	},
{G,0,"elven lumber mill (summer)",				 2, 102	},
{G,0,"troll lumber mill (summer)",				 2, 103	},
{G,0,"stables (summer)",					 2, 104	},
{G,0,"ogre mound (summer)",					 2, 105	},
{G,0,"human blacksmith (summer)",				 2, 106	},
{G,0,"orc blacksmith (summer)",					 2, 107	},
{G,0,"human shipyard (summer)",					 2, 108	},
{G,0,"orc shipyard (summer)",					 2, 109	},
{G,0,"human foundry (summer)",					 2, 110	},
{G,0,"orc foundry (summer)",					 2, 111	},
{G,0,"human refinery (summer)",					 2, 112	},
{G,0,"orc refinery (summer)",					 2, 113	},
{G,0,"human oil well (summer)",					 2, 114	},
{G,0,"orc oil well (summer)",					 2, 115	},
{G,0,"castle (summer)",						 2, 116	},
{G,0,"fortress (summer)",					 2, 117	},
{G,0,"oil patch (summer)",					 2, 118	},
{G,0,"gold mine (summer)",					 2, 119	},
{G,0,"corpses",							 2, 120	},
{G,0,"destroyed site (summer)",					 2, 121	},
{G,0,"peasant with wood",					 2, 122	},
{G,0,"peon with wood",						 2, 123	},
{G,0,"peasant with gold",					 2, 124	},
{G,0,"peon with gold",						 2, 125	},
{G,0,"human tanker (full)",					 2, 126	},
{G,0,"orc tanker (full)",					 2, 127	},
{G,0,"keep (winter)",						18, 128	},
{G,0,"stronghold (winter)",					18, 129	},
{G,0,"gryphon aviary (winter)",					18, 130	},
{G,0,"dragon roost (winter)",					18, 131	},
{G,0,"gnomish inventor (winter)",				18, 132	},
{G,0,"goblin alchemist (winter)",				18, 133	},
{G,0,"farm (winter)",						18, 134	},
{G,0,"pig farm (winter)",					18, 135	},
{G,0,"human barracks (winter)",					18, 136	},
{G,0,"orc barracks (winter)",					18, 137	},
{G,0,"church (winter)",						18, 138	},
{G,0,"altar of storms (winter)",				18, 139	},
{G,0,"human scout tower (winter)",				18, 140	},
{G,0,"orc scout tower (winter)",				18, 141	},
{G,0,"town hall (winter)",					18, 142	},
{G,0,"great hall (winter)",					18, 143	},
{G,0,"elven lumber mill (winter)",				18, 144	},
{G,0,"troll lumber mill (winter)",				18, 145	},
{G,0,"stables (winter)",					18, 146	},
{G,0,"ogre mound (winter)",					18, 147	},
{G,0,"human blacksmith (winter)",				18, 148	},
{G,0,"orc blacksmith (winter)",					18, 149	},
{G,0,"human shipyard (winter)",					18, 150	},
{G,0,"orc shipyard (winter)",					18, 151	},
{G,0,"human foundry (winter)",					18, 152	},
{G,0,"orc foundry (winter)",					18, 153	},
{G,0,"human refinery (winter)",					18, 154	},
{G,0,"orc refinery (winter)",					18, 155	},
{G,0,"human oil well (winter)",					18, 156	},
{G,0,"orc oil well (winter)",					18, 157	},
{G,0,"castle (winter)",						18, 158	},
{G,0,"fortress (winter)",					18, 159	},
{G,0,"mage tower (winter)",					18, 160	},
{G,0,"temple of the damned (winter)",				18, 161	},
{G,0,"gold mine (winter)",					18, 162	},
{G,0,"destroyed site (winter)",					18, 163	},
{G,0,"x (human player startpoint)",				 2, 164	},
{G,0,"o (orc player startpoint)",				 2, 165	},
{G,0,"circle of power",						 2, 166	},
{G,0,"dark portal (summer)",					 2, 167	},
{G,0,"wall (summer)",						 2, 168	},
{G,0,"human guard tower (winter)",				18, 169	},
{G,0,"orc guard tower (winter)",				18, 170	},
{G,0,"human cannon tower (winter)",				18, 171	},
{G,0,"orc cannon tower (winter)",				18, 172	},
{G,0,"farm (wasteland)",					10, 173	},
{G,0,"pig farm (wasteland)",					10, 174	},
{G,0,"elven lumber mill (wasteland)",				10, 175	},
{G,0,"troll lumber mill (wasteland)",				10, 176	},
{G,0,"human oil well (wasteland)",				10, 177	},
{G,0,"orc oil well (wasteland)",				10, 178	},
{G,0,"gold mine (wasteland)",					10, 179	},
{G,0,"oil patch (wasteland)",					10, 180	},
{G,0,"runestone (summer,wasteland)",				 2, 181	},
{G,0,"gnomish submarine (wasteland)",				10, 182	},
{G,0,"giant turtle (wasteland)",				10, 183	},
{G,0,"dark portal (winter)",					18, 184	},
{G,0,"dark portal (wasteland)",					10, 185	},
{G,0,"runestone (winter)",					18, 186	},
{U,0,"gold,wood,oil,mana",					 2, 187	},
{G,0,"small destroyed site (wasteland)",			10, 188	},
{G,0,"small destroyed site (summer)",				 2, 189	},
{G,0,"small destroyed site (winter)",				18, 190	},
{G,0,"destroyed site (wasteland)",				10, 191	},
//--------------------------------------------------
{P,0,"campaigns/human/level01h",				 192	},
{P,0,"campaigns/orc/level01o",					 193	},
{P,0,"campaigns/human/level02h",				 194	},
{P,0,"campaigns/orc/level02o",					 195	},
{P,0,"campaigns/human/level03h",				 196	},
{P,0,"campaigns/orc/level03o",					 197	},
{P,0,"campaigns/human/level04h",				 198	},
{P,0,"campaigns/orc/level04o",					 199	},
{P,0,"campaigns/human/level05h",				 200	},
{P,0,"campaigns/orc/level05o",					 201	},
{P,0,"campaigns/human/level06h",				 202	},
{P,0,"campaigns/orc/level06o",					 203	},
{P,0,"campaigns/human/level07h",				 204	},
{P,0,"campaigns/orc/level07o",					 205	},
{P,0,"campaigns/human/level08h",				 206	},
{P,0,"campaigns/orc/level08o",					 207	},
{P,0,"campaigns/human/level09h",				 208	},
{P,0,"campaigns/orc/level09o",					 209	},
{P,0,"campaigns/human/level10h",				 210	},
{P,0,"campaigns/orc/level10o",					 211	},
{P,0,"campaigns/human/level11h",				 212	},
{P,0,"campaigns/orc/level11o",					 213	},
{P,0,"campaigns/human/level12h",				 214	},
{P,0,"campaigns/orc/level12o",					 215	},
{P,0,"campaigns/human/level13h",				 216	},
{P,0,"campaigns/orc/level13o",					 217	},
{P,0,"campaigns/human/level14h",				 218	},
{P,0,"campaigns/orc/level14o",					 219	},
// --------------------------------------------------
 // FIXME: need better names
{P,0,"puds/internal/internal01",				 220	},
{P,0,"puds/internal/internal02",				 221	},
{P,0,"puds/internal/internal03",				 222	},
{P,0,"puds/internal/internal04",				 223	},
{P,0,"puds/internal/internal05",				 224	},
{P,0,"puds/internal/internal06",				 225	},
{P,0,"puds/internal/internal07",				 226	},
{P,0,"puds/internal/internal08",				 227	},
{P,0,"puds/internal/internal09",				 228	},
{P,0,"puds/internal/internal10",				 229	},
{P,0,"puds/internal/internal11",				 230	},
{P,0,"puds/internal/internal12",				 231	},
{P,0,"puds/internal/internal13",				 232	},
{P,0,"puds/internal/internal14",				 233	},
{P,0,"puds/internal/internal15",				 234	},
{P,0,"puds/internal/internal16",				 235	},
{P,0,"puds/internal/internal17",				 236	},
{P,0,"puds/internal/internal18",				 237	},
{P,0,"puds/internal/internal19",				 238	},
{P,0,"puds/internal/internal20",				 239	},
{P,0,"puds/internal/internal21",				 240	},
{P,0,"puds/internal/internal22",				 241	},
{P,0,"puds/internal/internal23",				 242	},
{P,0,"puds/internal/internal24",				 243	},
{P,0,"puds/internal/internal25",				 244	},
{P,0,"puds/internal/internal26",				 245	},
{P,0,"puds/internal/internal27",				 246	},
{P,0,"puds/internal/internal28",				 247	},
// -------------------------------------------------
{P,0,"puds/demo/demo01",					 248	},
{P,0,"puds/demo/demo02",					 249	},
{P,0,"puds/demo/demo03",					 250	},
{P,0,"puds/demo/demo04",					 251	},
// --------------------------------------------------
{G,0,"land construction site (summer,wasteland)",		 2, 252	},
{G,0,"human shipyard construction site (summer,wasteland)",	 2, 253	},
{G,0,"orc shipyard construction site (summer,wasteland)",	 2, 254	},
{G,0,"human oil well construction site (summer)",		 2, 255	},
{G,0,"orc oil well construction site (summer)",			 2, 256	},
{G,0,"human refinery construction site (summer,wasteland)",	 2, 257	},
{G,0,"orc refinery construction site (summer,wasteland)",	 2, 258	},
{G,0,"human foundry construction site (summer,wasteland)",	 2, 259	},
{G,0,"orc foundry construction site (summer,wasteland)",	 2, 260	},
{G,0,"wall construction site (summer)",				 2, 261	},
{G,0,"land construction site (winter)",				18, 262 },
{G,0,"human shipyard construction site (winter)",		18, 263 },
{G,0,"orc shipyard construction site (winter)",			18, 264 },
{G,0,"human oil well construction site (winter)",		18, 265 },
{G,0,"orc oil well construction site (winter)",			18, 266 },
{G,0,"human refinery construction site (winter)",		18, 267 },
{G,0,"orc refinery construction site (winter)",			18, 268 },
{G,0,"human foundry construction site (winter)",		18, 269 },
{G,0,"orc foundry construction site (winter)",			18, 270 },
{G,0,"human oil well construction site (wasteland)",		10, 271 },
{G,0,"orc oil well construction site (wasteland)",		10, 272 },
{G,0,"wall (winter)",						18, 273 },
{G,0,"wall (wasteland)",					10, 274 },
{G,0,"wall construction site (winter)",				18, 275 },
{G,0,"wall construction site (wasteland)",			10, 276 },
// 277 Control programs for computer player AI
// 278 Control programs for unit movement
// --------------------------------------------------
#ifdef NEW_NAMES
{N,0,"ui/fonts/large-episode-titles",				279	},
{N,0,"ui/fonts/small-episode-titles",				280	},
{N,0,"ui/fonts/large",						281	},
{N,0,"ui/fonts/game",						282	},
{N,0,"ui/fonts/small ",						283	},
#else
{N,0,"large font episode titles",				279	},
{N,0,"small font episode titles",				280	},
{N,0,"large font",						281	},
{N,0,"small font",						282	},
{N,0,"game font",						283	},
#endif
// 284-286 unknown
// --------------------------------------------------
{I,0,"Map border (Top,Humans)",					 2, 287	},
{I,0,"Map border (Top,Orcs)",					 2, 288	},
{I,0,"Map border (Right,Humans)",				 2, 289	},
{I,0,"Map border (Right,Orcs)",					 2, 290	},
{I,0,"Map border (Bottom,Humans)",				 2, 291	},
{I,0,"Map border (Bottom,Orcs)",				 2, 292	},
{I,0,"Minimap border (Top,Humans)",				 2, 293	},
{I,0,"Minimap border (Top,Orcs)",				 2, 294	},
{I,0,"Minimap (Humans)",					 2, 295	},
{I,0,"Minimap (Orcs)",						 2, 296	},
{I,0,"Panel (Bottom,Humans)",					 2, 297	},
{I,0,"Panel (Bottom,Orcs)",					 2, 298	},
{I,0,"title",							300, 299},
// --------------------------------------------------
#ifdef NEW_NAMES
{C,0,"ui/human/cursors/human gauntlet",				 2, 301 },
{C,0,"ui/orc/cursors/orcish claw",				 2, 302 },
{C,0,"ui/human/cursors/human don't click here",			 2, 303 },
{C,0,"ui/orc/cursors/orcish don't click here",			 2, 304 },
{C,0,"ui/human/cursors/yellow eagle",				 2, 305 },
{C,0,"ui/orc/cursors/yellow crosshairs",			 2, 306 },
{C,0,"ui/human/cursors/red eagle",				 2, 307 },
{C,0,"ui/orc/cursors/red crosshairs",				 2, 308 },
{C,0,"ui/human/cursors/green eagle",				 2, 309 },
{C,0,"ui/orc/cursors/green crosshairs",				 2, 310 },
{C,0,"ui/cursors/magnifying glass",				 2, 311 },
{C,0,"ui/cursors/small green cross",				 2, 312 },
{C,0,"ui/cursors/hourglass",					 2, 313 },
{C,0,"ui/cursors/blue arrow NW",				 2, 314 },
{C,0,"ui/cursors/arrow N",					 2, 315 },
{C,0,"ui/cursors/arrow NE",					 2, 316 },
{C,0,"ui/cursors/arrow E",					 2, 317 },
{C,0,"ui/cursors/arrow SE",					 2, 318 },
{C,0,"ui/cursors/arrow S",					 2, 319 },
{C,0,"ui/cursors/arrow SW",					 2, 320 },
{C,0,"ui/cursors/arrow W",					 2, 321 },
{C,0,"ui/cursors/arrow NW",					 2, 322 },
#else
{C,0,"human gauntlet",						 2, 301 },
{C,0,"orcish claw",						 2, 302 },
{C,0,"human don't click here",					 2, 303 },
{C,0,"orcish don't click here",					 2, 304 },
{C,0,"yellow eagle",						 2, 305 },
{C,0,"yellow crosshairs",					 2, 306 },
{C,0,"red eagle",						 2, 307 },
{C,0,"red crosshairs",						 2, 308 },
{C,0,"green eagle",						 2, 309 },
{C,0,"green crosshairs",					 2, 310 },
{C,0,"magnifying glass",					 2, 311 },
{C,0,"small green cross",					 2, 312 },
{C,0,"hourglass",						 2, 313 },
{C,0,"blue arrow NW",						 2, 314 },
{C,0,"arrow N",							 2, 315 },
{C,0,"arrow NE",						 2, 316 },
{C,0,"arrow E",							 2, 317 },
{C,0,"arrow SE",						 2, 318 },
{C,0,"arrow S",							 2, 319 },
{C,0,"arrow SW",						 2, 320 },
{C,0,"arrow W",							 2, 321 },
{C,0,"arrow NW",						 2, 322 },
#endif
{U,0,"bloodlust,haste,slow,invis.,shield",			 2, 323 },
// --------------------------------------------------------
{G,0,"lightning",						 2, 324 },
{G,0,"gryphon hammer",						 2, 325 },
// "fireball (also dragon breath)"
{G,0,"dragon breath",						 2, 326 },
// "fireball (when casting flameshield)"
{G,0,"fireball",						 2, 327 },
{G,0,"flame shield",						 2, 328 },
{G,0,"blizzard",						 2, 329 },
{G,0,"death and decay",						 2, 330 },
{G,0,"big cannon",						 2, 331 },
{G,0,"exorcism",						 2, 332 },
{G,0,"heal effect",						 2, 333 },
{G,0,"touch of death",						 2, 334 },
{G,0,"rune",							 2, 335 },
{G,0,"tornado",							 2, 336 },
{G,0,"catapult rock",						 2, 337 },
{G,0,"ballista bolt",						 2, 338 },
{G,0,"arrow",							 2, 339 },
{G,0,"axe",							 2, 340 },
{G,0,"submarine missile",					 2, 341 },
{G,0,"turtle missile",						 2, 342 },
{G,0,"small fire",						 2, 343 },
{G,0,"big fire",						 2, 344 },
{G,0,"ballista-catapult impact",				 2, 345 },
{G,0,"normal spell",						 2, 346 },
{G,0,"explosion",						 2, 347 },
{G,0,"cannon",							 2, 348 },
{G,0,"cannon explosion",					 2, 349 },
{G,0,"cannon-tower explosion",					 2, 350 },
{G,0,"daemon fire",						 2, 351 },
{G,0,"green cross",						 2, 352 },
{G,0,"unit shadow",						 2, 353 },
{U,0,"human panel",						 2, 354 },
{U,0,"orcish panel",						 2, 355 },
#ifdef NEW_NAMES
{G,0,"tilesets/summer/icons",					 2, 356 },
{G,0,"tilesets/winter/icons",					18, 357 },
{G,0,"tilesets/wasteland/icons",				10, 358 },
#else
{G,0,"icons (summer)",						 2, 356 },
{G,0,"icons (winter)",						18, 357 },
{G,0,"icons (wasteland)",					10, 358 },
#endif
{W,0,"click",							432	},
{W,0,"highclick",						435	},

{R,2,"swamp",							438	},
{T,2,"swamp",					438,	439,	440,	441 },
// --------------------------------------------------
{P,2,"campaigns/human-exp/levelx01h",				 446	},
{P,2,"campaigns/orc-exp/levelx01o",				 447	},
{P,2,"campaigns/human-exp/levelx02h",				 448	},
{P,2,"campaigns/orc-exp/levelx02o",				 449	},
{P,2,"campaigns/human-exp/levelx03h",				 450	},
{P,2,"campaigns/orc-exp/levelx03o",				 451	},
{P,2,"campaigns/human-exp/levelx04h",				 452	},
{P,2,"campaigns/orc-exp/levelx04o",				 453	},
{P,2,"campaigns/human-exp/levelx05h",				 454	},
{P,2,"campaigns/orc-exp/levelx05o",				 455	},
{P,2,"campaigns/human-exp/levelx06h",				 456	},
{P,2,"campaigns/orc-exp/levelx06o",				 457	},
{P,2,"campaigns/human-exp/levelx07h",				 458	},
{P,2,"campaigns/orc-exp/levelx07o",				 459	},
{P,2,"campaigns/human-exp/levelx08h",				 460	},
{P,2,"campaigns/orc-exp/levelx08o",				 461	},
{P,2,"campaigns/human-exp/levelx09h",				 462	},
{P,2,"campaigns/orc-exp/levelx09o",				 463	},
{P,2,"campaigns/human-exp/levelx10h",				 464	},
{P,2,"campaigns/orc-exp/levelx10o",				 465	},
{P,2,"campaigns/human-exp/levelx11h",				 466	},
{P,2,"campaigns/orc-exp/levelx11o",				 467	},
{P,2,"campaigns/human-exp/levelx12h",				 468	},
{P,2,"campaigns/orc-exp/levelx12o",				 469	},
// ------------------------------------------
{G,2,"critter (swamp)",						438, 470 },
#ifdef NEW_NAMES
{G,2,"tilesets/swamp/icons",					438, 471 },
#else
{G,2,"icons (swamp)",						438, 471 },
#endif
// 472: default UDTA for expansion PUDs
{G,2,"keep (swamp)",						438, 473 },
{G,2,"stronghold (swamp)",					438, 474 },
{G,2,"gryphon aviary (swamp)",					438, 475 },
{G,2,"dragon roost (swamp)",					438, 476 },
{G,2,"gnomish inventor (swamp)",				438, 477 },
{G,2,"goblin alchemist (swamp)",				438, 478 },
{G,2,"farm (swamp)",						438, 479 },
{G,2,"pig farm (swamp)",					438, 480 },
{G,2,"human barracks (swamp)",					438, 481 },
{G,2,"orc barracks (swamp)",					438, 482 },
{G,2,"church (swamp)",						438, 483 },
{G,2,"altar of storms (swamp)",					438, 484 },
{G,2,"human scout tower (swamp)",				438, 485 },
{G,2,"orc scout tower (swamp)",					438, 486 },
{G,2,"town hall (swamp)",					438, 487 },
{G,2,"great hall (swamp)",					438, 488 },
{G,2,"elven lumber mill (swamp)",				438, 489 },
{G,2,"troll lumber mill (swamp)",				438, 490 },
{G,2,"stables (swamp)",						438, 491 },
{G,2,"ogre mound (swamp)",					438, 492 },
{G,2,"human blacksmith (swamp)",				438, 493 },
{G,2,"orc blacksmith (swamp)",					438, 494 },
{G,2,"human shipyard (swamp)",					438, 495 },
{G,2,"orc shipyard (swamp)",					438, 496 },
{G,2,"human foundry (swamp)",					438, 497 },
{G,2,"orc foundry (swamp)",					438, 498 },
{G,2,"human refinery (swamp)",					438, 499 },
{G,2,"orc refinery (swamp)",					438, 500 },
{G,2,"human oil well (swamp)",					438, 501 },
{G,2,"orc oil well (swamp)",					438, 502 },
{G,2,"castle (swamp)",						438, 503 },
{G,2,"fortress (swamp)",					438, 504 },
{G,2,"mage tower (swamp)",					438, 505 },
{G,2,"temple of the damned (swamp)",				438, 506 },
{G,2,"human guard tower (swamp)",				438, 507 },
{G,2,"orc guard tower (swamp)",					438, 508 },
{G,2,"human cannon tower (swamp)",				438, 509 },
{G,2,"orc cannon tower (swamp)",				438, 510 },
{G,2,"gold mine (swamp)",					438, 511 },
{G,2,"destroyed site (swamp)",					438, 512 },
{G,2,"dark portal (swamp)",					438, 513 },
{G,2,"runestone (swamp)",					438, 514 },
{G,2,"oil patch (swamp)",					438, 515 },
{G,2,"human shipyard construction site (swamp)",		438, 516 },
{G,2,"orc shipyard construction site (swamp)",			438, 517 },
{G,2,"human oil well construction site (swamp)",		438, 518 },
{G,2,"orc oil well construction site (swamp)",			438, 519 },
{G,2,"human refinery construction site (swamp)",		438, 520 },
{G,2,"orc refinery construction site (swamp)",			438, 521 },
{G,2,"human foundry construction site (swamp)",			438, 522 },
{G,2,"orc foundry construction site (swamp)",			438, 523 },
{G,2,"small destroyed site (swamp)",				438, 524 },
{G,2,"circle of power (swamp)",					438, 525 },
{G,2,"gnomish submarine (swamp)",				438, 526 },
{G,2,"giant turtle (swamp)",					438, 527 },

///////////////////////////////////////////////////////////////////////////////
//	SOUNDS
///////////////////////////////////////////////////////////////////////////////

{F,0,"sfxdat.sud",				5000 },

// 0 file length
// 1 description
{W,0,"placement error",						  2	},
{W,0,"placement sucess",					  3	}, 
{W,0,"building construction",					  4	}, 
{W,0,"basic human voices selected 1",				  5	}, 
{W,0,"basic orc voices selected 1",				  6	}, 
{W,0,"basic human voices selected 2",				  7	}, 
{W,0,"basic orc voices selected 2",				  8	}, 
{W,0,"basic human voices selected 3",				  9	}, 
{W,0,"basic orc voices selected 3",				 10	},
{W,0,"basic human voices selected 4",				 11	},
{W,0,"basic orc voices selected 4",				 12	},
{W,0,"basic human voices selected 5",				 13	},
{W,0,"basic orc voices selected 5",				 14	},
{W,0,"basic human voices selected 6",				 15	},
{W,0,"basic orc voices selected 6",				 16	},
{W,0,"basic human voices annoyed 1",				 17	},
{W,0,"basic orc voices annoyed 1",				 18	},
{W,0,"basic human voices annoyed 2",				 19	},
{W,0,"basic orc voices annoyed 2",				 20	},
{W,0,"basic human voices annoyed 3",				 21	},
{W,0,"basic orc voices annoyed 3",				 22	},
{W,0,"basic human voices annoyed 4",				 23	},
{W,0,"basic orc voices annoyed 4",				 24	},
{W,0,"basic human voices annoyed 5",				 25	},
{W,0,"basic orc voices annoyed 5",				 26	},
{W,0,"basic human voices annoyed 6",				 27	},
{W,0,"basic orc voices annoyed 6",				 28	},
{W,0,"basic human voices annoyed 7",				 29	},
{W,0,"basic orc voices annoyed 7",				 30	},
{W,0,"explosion",						 31	},
{W,0,"basic human voices acknowledgement 1",			 32	},
{W,0,"basic orc voices acknowledgement 1",			 33	},
{W,0,"basic human voices acknowledgement 2",			 34	},
{W,0,"basic orc voices acknowledgement 2",			 35	},
{W,0,"basic human voices acknowledgement 3",			 36	},
{W,0,"basic orc voices acknowledgement 3",			 37	},
{W,0,"basic human voices acknowledgement 4",			 38	},
{W,0,"basic orc voices acknowledgement 4",			 39	},
{W,0,"basic human voices work complete",			 40	},
{W,0,"basic orc voices work complete",				 41	},
{W,0,"peasant work complete",					 42	},
{W,0,"basic human voices ready",				 43	},
{W,0,"basic orc voices ready",					 44	},
{W,0,"basic human voices help 1",				 45	},
{W,0,"basic orc voices help 1",					 46	},
{W,0,"basic human voices help 2",				 47	},
{W,0,"basic orc voices help 2",					 48	},
{W,0,"basic human voices dead",					 49	},
{W,0,"basic orc voices dead",					 50	},
{W,0,"ship sinking",						 51	},
{W,0,"explosion 1",						 52	},
{W,0,"explosion 2",						 53	},
{W,0,"explosion 3",						 54	},
{W,0,"catapult-ballista attack",				 55	},
{W,0,"tree chopping 1",						 56	},
{W,0,"tree chopping 2",						 57	},
{W,0,"tree chopping 3",						 58	},
{W,0,"tree chopping 4",						 59	},
{W,0,"sword attack 1",						 60	},
{W,0,"sword attack 2",						 61	},
{W,0,"sword attack 3",						 62	},
{W,0,"punch",							 63	},
{W,0,"fireball hit",						 64	},
{W,0,"fireball throw",						 65	},
{W,0,"bow throw",						 66	},
{W,0,"bow hit",							 67	},
{W,0,"spells basic spell sound",				 68	},
{W,0,"blacksmith",						 69	},
{W,0,"church",							 70	},
{W,0,"altar of storms",						 71	},
{W,0,"stables",							 72	},
{W,0,"ogre mound",						 73	},
{W,0,"farm",							 74	},
{W,0,"pig farm",						 75	},
{W,0,"gold mine",						 76	},
{W,0,"axe throw",						 77	},
{W,0,"tanker acknowledgement",					 78	},
{W,0,"fist",							 79	},
{W,0,"shipyard",						 80	},
{W,0,"peasant attack",						 81	},
{W,0,"oil platform",						 82	},
{W,0,"oil refinery",						 83	},
{W,0,"lumbermill",						 84	},
{W,0,"transport docking",					 85	},
{W,0,"burning",							 86	},
{W,0,"gryphon aviary",						 87	},
{W,0,"dragon roost",						 88	},
{W,0,"foundry",							 89	},
{W,0,"gnomish inventor",					 90	},
{W,0,"goblin alchemist",					 91	},
{W,0,"mage tower",						 92	},
{W,0,"temple of the damned",					 93	},
{W,0,"capture (human)",						 94	},
{W,0,"capture (orc)",						 95	},
{W,0,"rescue (human)",						 96	},
{W,0,"rescue (orc)",						 97	},
{W,0,"bloodlust",						 98	},
{W,0,"death and decay",						 99	},
{W,0,"death coil",						100	},
{W,0,"exorcism",						101	},
{W,0,"flame shield",						102	},
{W,0,"haste",							103	},
{W,0,"healing",							104	},
{W,0,"holy vision",						105	},
{W,0,"blizzard",						106	},
{W,0,"invisibility",						107	},
{W,0,"eye of kilrogg",						108	},
{W,0,"polymorph",						109	},
{W,0,"slow",							110	},
{W,0,"lightning",						111	},
{W,0,"touch of darkness",					112	},
{W,0,"unholy armour",						113	},
{W,0,"whirlwind",						114	},
{W,0,"peon ready",						115	},
{W,0,"death knight annoyed 1",					116	},
{W,0,"death knight annoyed 2",					117	},
{W,0,"death knight annoyed 3",					118	},
{W,0,"death knight ready",					119	},
{W,0,"death knight selected 1",					120	},
{W,0,"death knight selected 2",					121	},
{W,0,"death knight acknowledgement 1",				122	},
{W,0,"death knight acknowledgement 2",				123	},
{W,0,"death knight acknowledgement 3",				124	},
{W,0,"dwarven demolition squad annoyed 1",			125	},
{W,0,"dwarven demolition squad annoyed 2",			126	},
{W,0,"dwarven demolition squad annoyed 3",			127	},
{W,0,"dwarven demolition squad ready",				128	},
{W,0,"dwarven demolition squad selected 1",			129	},
{W,0,"dwarven demolition squad selected 2",			130	},
{W,0,"dwarven demolition squad acknowledgement 1",		131	},
{W,0,"dwarven demolition squad acknowledgement 2",		132	},
{W,0,"dwarven demolition squad acknowledgement 3",		133	},
{W,0,"dwarven demolition squad acknowledgement 4",		134	},
{W,0,"dwarven demolition squad acknowledgement 5",		135	},
{W,0,"elven archer-ranger annoyed 1",				136	},
{W,0,"elven archer-ranger annoyed 2",				137	},
{W,0,"elven archer-ranger annoyed 3",				138	},
{W,0,"elven archer-ranger ready",				139	},
{W,0,"elven archer-ranger selected 1",				140	},
{W,0,"elven archer-ranger selected 2",				141	},
{W,0,"elven archer-ranger selected 3",				142	},
{W,0,"elven archer-ranger selected 4",				143	},
{W,0,"elven archer-ranger acknowledgement 1",			144	},
{W,0,"elven archer-ranger acknowledgement 2",			145	},
{W,0,"elven archer-ranger acknowledgement 3",			146	},
{W,0,"elven archer-ranger acknowledgement 4",			147	},
{W,0,"gnomish flying machine annoyed 1",			148	},
{W,0,"gnomish flying machine annoyed 2",			149	},
{W,0,"gnomish flying machine annoyed 3",			150	},
{W,0,"gnomish flying machine annoyed 4",			151	},
{W,0,"gnomish flying machine annoyed 5",			152	},
{W,0,"gnomish flying machine ready",				153	},
{W,0,"gnomish flying machine acknowledgement 1",		154	},
{W,0,"goblin sappers annoyed 1",				155	},
{W,0,"goblin sappers annoyed 2",				156	},
{W,0,"goblin sappers annoyed 3",				157	},
{W,0,"goblin sappers ready",					158	},
{W,0,"goblin sappers selected 1",				159	},
{W,0,"goblin sappers selected 2",				160	},
{W,0,"goblin sappers selected 3",				161	},
{W,0,"goblin sappers selected 4",				162	},
{W,0,"goblin sappers acknowledgement 1",			163	},
{W,0,"goblin sappers acknowledgement 2",			164	},
{W,0,"goblin sappers acknowledgement 3",			165	},
{W,0,"goblin sappers acknowledgement 4",			166	},
{W,0,"goblin zeppelin annoyed 1",				167	},
{W,0,"goblin zeppelin annoyed 2",				168	},
{W,0,"goblin zeppelin ready",					169	},
{W,0,"goblin zeppelin acknowledgement 1",			170	},
{W,0,"knight annoyed 1",					171	},
{W,0,"knight annoyed 2",					172	},
{W,0,"knight annoyed 3",					173	},
{W,0,"knight ready",						174	},
{W,0,"knight selected 1",					175	},
{W,0,"knight selected 2",					176	},
{W,0,"knight selected 3",					177	},
{W,0,"knight selected 4",					178	},
{W,0,"knight acknowledgement 1",				179	},
{W,0,"knight acknowledgement 2",				180	},
{W,0,"knight acknowledgement 3",				181	},
{W,0,"knight acknowledgement 4",				182	},
{W,0,"paladin annoyed 1",					183	},
{W,0,"paladin annoyed 2",					184	},
{W,0,"paladin annoyed 3",					185	},
{W,0,"paladin ready",						186	},
{W,0,"paladin selected 1",					187	},
{W,0,"paladin selected 2",					188	},
{W,0,"paladin selected 3",					189	},
{W,0,"paladin selected 4",					190	},
{W,0,"paladin acknowledgement 1",				191	},
{W,0,"paladin acknowledgement 2",				192	},
{W,0,"paladin acknowledgement 3",				193	},
{W,0,"paladin acknowledgement 4",				194	},
{W,0,"ogre annoyed 1",						195	},
{W,0,"ogre annoyed 2",						196	},
{W,0,"ogre annoyed 3",						197	},
{W,0,"ogre annoyed 4",						198	},
{W,0,"ogre annoyed 5",						199	},
{W,0,"ogre ready",						200	},
{W,0,"ogre selected 1",						201	},
{W,0,"ogre selected 2",						202	},
{W,0,"ogre selected 3",						203	},
{W,0,"ogre selected 4",						204	},
{W,0,"ogre acknowledgement 1",					205	},
{W,0,"ogre acknowledgement 2",					206	},
{W,0,"ogre acknowledgement 3",					207	},
{W,0,"ogre-mage annoyed 1",					208	},
{W,0,"ogre-mage annoyed 2",					209	},
{W,0,"ogre-mage annoyed 3",					210	},
{W,0,"ogre-mage ready",						211	},
{W,0,"ogre-mage selected 1",					212	},
{W,0,"ogre-mage selected 2",					213	},
{W,0,"ogre-mage selected 3",					214	},
{W,0,"ogre-mage selected 4",					215	},
{W,0,"ogre-mage acknowledgement 1",				216	},
{W,0,"ogre-mage acknowledgement 2",				217	},
{W,0,"ogre-mage acknowledgement 3",				218	},
{W,0,"ships human annoyed 1",					219	},
{W,0,"ships orc annoyed 1",					220	},
{W,0,"ships human annoyed 2",					221	},
{W,0,"ships orc annoyed 2",					222	},
{W,0,"ships human annoyed 3",					223	},
{W,0,"ships orc annoyed 3",					224	},
{W,0,"ships human ready",					225	},
{W,0,"ships orc ready",						226	},
{W,0,"ships human selected 1",					227	},
{W,0,"ships orc selected 1",					228	},
{W,0,"ships human selected 2",					229	},
{W,0,"ships orc selected 2",					230	},
{W,0,"ships human selected 3",					231	},
{W,0,"ships orc selected 3",					232	},
{W,0,"ships human acknowledgement 1",				233	},
{W,0,"ships orc acknowledgement 1",				234	},
{W,0,"ships human acknowledgement 2",				235	},
{W,0,"ships orc acknowledgement 2",				236	},
{W,0,"ships human acknowledgement 3",				237	},
{W,0,"ships orc acknowledgement 3",				238	},
{W,0,"ships submarine annoyed 1",				239	},
{W,0,"ships submarine annoyed 2",				240	},
{W,0,"ships submarine annoyed 3",				241	},
{W,0,"ships submarine annoyed 4",				242	},
{W,0,"troll axethrower-berserker annoyed 1",			243	},
{W,0,"troll axethrower-berserker annoyed 2",			244	},
{W,0,"troll axethrower-berserker annoyed 3",			245	},
{W,0,"troll axethrower-berserker ready",			246	},
{W,0,"troll axethrower-berserker selected 1",			247	},
{W,0,"troll axethrower-berserker selected 2",			248	},
{W,0,"troll axethrower-berserker selected 3",			249	},
{W,0,"troll axethrower-berserker acknowledgement 1",		250	},
{W,0,"troll axethrower-berserker acknowledgement 2",		251	},
{W,0,"troll axethrower-berserker acknowledgement 3",		252	},
{W,0,"mage annoyed 1",						253	},
{W,0,"mage annoyed 2",						254	},
{W,0,"mage annoyed 3",						255	},
{W,0,"mage ready",						256	},
{W,0,"mage selected 1",						257	},
{W,0,"mage selected 2",						258	},
{W,0,"mage selected 3",						259	},
{W,0,"mage acknowledgement 1",					260	},
{W,0,"mage acknowledgement 2",					261	},
{W,0,"mage acknowledgement 3",					262	},
{W,0,"peasant ready",						263	},
{W,0,"peasant annoyed 1",					264	},
{W,0,"peasant annoyed 2",					265	},
{W,0,"peasant annoyed 3",					266	},
{W,0,"peasant annoyed 4",					267	},
{W,0,"peasant annoyed 5",					268	},
{W,0,"peasant annoyed 6",					269	},
{W,0,"peasant annoyed 7",					270	},
{W,0,"peasant selected 1",					271	},
{W,0,"peasant selected 2",					272	},
{W,0,"peasant selected 3",					273	},
{W,0,"peasant selected 4",					274	},
{W,0,"peasant acknowledgement 1",				275	},
{W,0,"peasant acknowledgement 2",				276	},
{W,0,"peasant acknowledgement 3",				277	},
{W,0,"peasant acknowledgement 4",				278	},
{W,0,"dragon ready 2",						279	},
{W,0,"dragon selected",						280	},
{W,0,"dragon acknowledgement 1",				281	},
{W,0,"dragon acknowledgement 2",				282	},
{W,0,"gryphon rider selected",					283	},
{W,0,"gryphon rider griffon1",					284	},
{W,0,"gryphon rider griffon2",					285	},
{W,0,"sheep selected",						286	},
{W,0,"sheep annoyed",						287	},
{W,0,"seal selected",						288	},
{W,0,"seal annoyed",						289	},
{W,0,"pig selected",						290	},
{W,0,"pig annoyed",						291	},
{W,0,"catapult-ballista movement",				292	},
{W,2,"alleria annoyed 1",					293	},
{W,2,"alleria annoyed 2",					294	},
{W,2,"alleria annoyed 3",					295	},
{W,2,"alleria selected 1",					296	},
{W,2,"alleria selected 2",					297	},
{W,2,"alleria selected 3",					298	},
{W,2,"alleria acknowledgement 1",				299	},
{W,2,"alleria acknowledgement 2",				300	},
{W,2,"alleria acknowledgement 3",				301	},
{W,2,"danath annoyed 1",					302	},
{W,2,"danath annoyed 2",					303	},
{W,2,"danath annoyed 3",					304	},
{W,2,"danath selected 1",					305	},
{W,2,"danath selected 2",					306	},
{W,2,"danath selected 3",					307	},
{W,2,"danath acknowledgement 1",				308	},
{W,2,"danath acknowledgement 2",				309	},
{W,2,"danath acknowledgement 3",				310	},
{W,2,"khadgar annoyed 1",					311	},
{W,2,"khadgar annoyed 2",					312	},
{W,2,"khadgar annoyed 3",					313	},
{W,2,"khadgar selected 1",					314	},
{W,2,"khadgar selected 2",					315	},
{W,2,"khadgar selected 3",					316	},
{W,2,"khadgar acknowledgement 1",				317	},
{W,2,"khadgar acknowledgement 2",				318	},
{W,2,"khadgar acknowledgement 3",				319	},
{W,2,"kurdran annoyed 1",					320	},
{W,2,"kurdran annoyed 2",					321	},
{W,2,"kurdran annoyed 3",					322	},
{W,2,"kurdran selected 1",					323	},
{W,2,"kurdran selected 2",					324	},
{W,2,"kurdran selected 3",					325	},
{W,2,"kurdran acknowledgement 1",				326	},
{W,2,"kurdran acknowledgement 2",				327	},
{W,2,"kurdran acknowledgement 3",				328	},
{W,2,"turalyon annoyed 1",					329	},
{W,2,"turalyon annoyed 2",					330	},
{W,2,"turalyon annoyed 3",					331	},
{W,2,"turalyon selected 1",					332	},
{W,2,"turalyon selected 2",					333	},
{W,2,"turalyon selected 3",					334	},
{W,2,"turalyon acknowledgement 1",				335	},
{W,2,"turalyon acknowledgement 2",				336	},
{W,2,"turalyon acknowledgement 3",				337	},
{W,2,"deathwing annoyed 1",					338	},
{W,2,"deathwing annoyed 2",					339	},
{W,2,"deathwing annoyed 3",					340	},
{W,2,"deathwing selected 1",					341	},
{W,2,"deathwing selected 2",					342	},
{W,2,"deathwing selected 3",					343	},
{W,2,"deathwing acknowledgement 1",				344	},
{W,2,"deathwing acknowledgement 2",				345	},
{W,2,"deathwing acknowledgement 3",				346	},
{W,2,"dentarg annoyed 1",					347	},
{W,2,"dentarg annoyed 2",					348	},
{W,2,"dentarg annoyed 3",					349	},
{W,2,"dentarg selected 1",					350	},
{W,2,"dentarg selected 2",					351	},
{W,2,"dentarg selected 3",					352	},
{W,2,"dentarg acknowledgement 1",				353	},
{W,2,"dentarg acknowledgement 2",				354	},
{W,2,"dentarg acknowledgement 3",				355	},
{W,2,"grom hellscream annoyed 1",				356	},
{W,2,"grom hellscream annoyed 2",				357	},
{W,2,"grom hellscream annoyed 3",				358	},
{W,2,"grom hellscream selected 1",				359	},
{W,2,"grom hellscream selected 2",				360	},
{W,2,"grom hellscream selected 3",				361	},
{W,2,"grom hellscream acknowledgement 1",			362	},
{W,2,"grom hellscream acknowledgement 2",			363	},
{W,2,"grom hellscream acknowledgement 3",			364	},
{W,2,"korgath bladefist annoyed 1",				365	},
{W,2,"korgath bladefist annoyed 2",				366	},
{W,2,"korgath bladefist annoyed 3",				367	},
{W,2,"korgath bladefist selected 1",				368	},
{W,2,"korgath bladefist selected 2",				369	},
{W,2,"korgath bladefist selected 3",				370	},
{W,2,"korgath bladefist acknowledgement 1",			371	},
{W,2,"korgath bladefist acknowledgement 2",			372	},
{W,2,"korgath bladefist acknowledgement 3",			373	},
{W,2,"teron gorefiend annoyed 1",				374	},
{W,2,"teron gorefiend annoyed 2",				375	},
{W,2,"teron gorefiend annoyed 3",				376	},
{W,2,"teron gorefiend selected 1",				377	},
{W,2,"teron gorefiend selected 2",				378	},
{W,2,"teron gorefiend selected 3",				379	},
{W,2,"teron gorefiend acknowledgement 1",			380	},
{W,2,"teron gorefiend acknowledgement 2",			381	},
{W,2,"teron gorefiend acknowledgement 3",			382	},
{W,2,"warthog selected",					383	},
{W,2,"warthog annoyed",						384	},

///////////////////////////////////////////////////////////////////////////////
//	INTERFACE
///////////////////////////////////////////////////////////////////////////////

{F,0,"rezdat.war",				3000 },
// (correct palette is #2 in maindat)
{U,0,"interface/buttons 1",					14, 0	}, 
// (correct palette is #2 in maindat)
{U,0,"interface/buttons 2",					14, 1	}, 
{I,0,"interface/cd-icon",					14, 2	},
{I,0,"interface/panel 1 (humans)",				14, 3	},
{I,0,"interface/panel 1 (orcs)",				14, 4	},
{I,0,"interface/panel 2 (humans)",				14, 5	},
{I,0,"interface/panel 2 (orcs)",				14, 6	},
{I,0,"interface/panel 3 (humans)",				14, 7	},
{I,0,"interface/panel 3 (orcs)",				14, 8	},
{I,0,"interface/panel 4 (humans)",				14, 9	},
{I,0,"interface/panel 4 (orcs)",				14, 10	},
{I,0,"interface/panel 5 (humans)",				14, 11	},
{I,0,"interface/panel 5 (orcs)",				14, 12	},
{I,0,"interface/Menu background with title",			14, 13	},
{I,0,"interface/Menu background without title",			16, 15	},
{I,0,"Act I   | Shores of Lordareon (Human)",			17, 19 },
{I,0,"Act I   | Seas of Blood (Orc)",				17, 20 },
{I,0,"Act II  | Khaz Modan (Human)",				17, 21 },
{I,0,"Act II  | Khaz Modan (Orc)",				17, 22 },
{I,0,"Act III | The Northlands (Human)",			17, 23 },
{I,0,"Act III | Quel'Thalas (Orc)",				17, 24 },
{I,0,"Act IV  | Return to Azeroth (Human)",			17, 25 },
{I,0,"Act IV  | Tides of Darkness",				17, 26 },

{I,0,"Credits background",					27, 28 },
{I,0,"The End (Humans)",					27, 29 },
{I,0,"Smashing of Lordaeron scroll (Orcs)",			32, 30 },
{I,2,"Patch",							14, 91 },
{I,2,"Credits for extension background",			93, 94 },
{I,2,"Act xI  | A Time for Heroes (Human)",			17, 96 },
{I,2,"Act xI  | Draenor, the Red World (Orc)",			17, 97 },
{I,2,"Act xII | Draenor, the Red World (Human)",		17, 98 },
{I,2,"Act xII | The Burning of Azeroth (Orc)",			17, 99 },
{I,2,"Act xIII| War in the Shadows (Human)",			17, 100 },
{I,2,"Act xIII| The Great Sea (Orc)",				17, 101 },
{I,2,"Act xIV | The Measure of Valor (Human)",			17, 102 },
{I,2,"Act xIV | Prelude to New Worlds (Orc)",			17, 103 },

};

/**
**	File names.
*/
char* UnitNames[110];

//----------------------------------------------------------------------------

/**
**	Print debug information of level 0.
*/
#define DebugLevel0(fmt...)	printf(fmt##)
/**
**	Print debug information of level 1.
*/
#define DebugLevel1(fmt...)	printf(fmt##)/**/
/**
**	Print debug information of level 2.
*/
#define DebugLevel2(fmt...)	printf(fmt##)/**/
/**
**	Print debug information of level 3.
*/
#define DebugLevel3(fmt...)	/* ALWAYS TURNED OFF */

//----------------------------------------------------------------------------
//	PNG
//----------------------------------------------------------------------------

/**
**	Save a png file.
**
**	@param name	File name
**	@param image	Graphic data
**	@param w	Graphic width 
**	@param h	Graphic height 
**	@param pal	Palette
*/
int SavePNG(const char* name,unsigned char* image,int w,int h
	,unsigned char* pal)
{
    FILE* fp;
    png_structp png_ptr;
    png_infop info_ptr;
    unsigned char** lines;
    int i;

    if( !(fp=fopen(name,"wb")) ) {
	printf("%s:",name);
	perror("Can't open file");
	return 1;
    }

    png_ptr=png_create_write_struct(PNG_LIBPNG_VER_STRING,NULL,NULL,NULL);
    if( !png_ptr ) {
	fclose(fp);
	return 1;
    }
    info_ptr=png_create_info_struct(png_ptr);
    if( !info_ptr ) {
	png_destroy_write_struct(&png_ptr,NULL);
	fclose(fp);
	return 1;
    }

    if( setjmp(png_ptr->jmpbuf) ) {
	// FIXME: must free buffers!!
	png_destroy_write_struct(&png_ptr,&info_ptr);
	fclose(fp);
	return 1;
    }
    png_init_io(png_ptr,fp);

    // zlib parameters
    png_set_compression_level(png_ptr,Z_BEST_COMPRESSION);

    //	prepare the file information

    info_ptr->width=w;
    info_ptr->height=h;
    info_ptr->bit_depth=8;
    info_ptr->color_type=PNG_COLOR_TYPE_PALETTE;
    info_ptr->interlace_type=0;
    info_ptr->valid|=PNG_INFO_PLTE;
    info_ptr->palette=(void*)pal;
    info_ptr->num_palette=256;

    png_write_info(png_ptr,info_ptr);	// write the file header information

    //	set transformation

    //	prepare image

    lines=malloc(h*sizeof(*lines));
    if( !lines ) {
	png_destroy_write_struct(&png_ptr,&info_ptr);
	fclose(fp);
	return 1;
    }

    for( i=0; i<h; ++i ) {
	lines[i]=image+i*w;
    }

    png_write_image(png_ptr,lines);
    png_write_end(png_ptr,info_ptr);

    png_destroy_write_struct(&png_ptr,&info_ptr);
    fclose(fp);

    free(lines);

    return 0;
}

//----------------------------------------------------------------------------
//	Archive
//----------------------------------------------------------------------------

/**
**	Open the archive file.
**
**	@param file	Archive file name
**	@param type	Archive type requested
*/
int OpenArchive(const char* file,int type)
{
    int f;
    struct stat stat_buf;
    unsigned char* buf;
    unsigned char* cp;
    unsigned char** op;
    int entries;
    int i;

    //
    //	Open the archive file
    //
    f=open(file,O_RDONLY|O_BINARY,0);
    if( f==-1 ) {
	printf("Can't open %s\n",file);
	exit(-1);
    }
    if( fstat(f,&stat_buf) ) {
	printf("Can't fstat %s\n",file);
	exit(-1);
    }
    DebugLevel3("Filesize %ld %ldk\n"
	,(long)stat_buf.(long)st_size,stat_buf.st_size/1024);

    //
    //	Read in the archive
    //
    buf=malloc(stat_buf.st_size);
    if( !buf ) {
	printf("Can't malloc %ld\n",(long)stat_buf.st_size);
	exit(-1);
    }
    if( read(f,buf,stat_buf.st_size)!=stat_buf.st_size ) {
	printf("Can't read %ld\n",(long)stat_buf.st_size);
	exit(-1);
    }
    close(f);

    cp=buf;
    i=FetchLE32(cp);
    DebugLevel2("Magic\t%08X\t",i);
    if( i!=0x19 ) {
	printf("Wrong magic %08x, expected %08x\n",i,0x00000019);
	exit(-1);
    }
    entries=FetchLE16(cp);
    DebugLevel2("Entries\t%5d\t",entries);
    i=FetchLE16(cp);
    DebugLevel2("ID\t%d\n",i);
    if( i!=type ) {
	printf("Wrong type %08x, expected %08x\n",i,type);
	exit(-1);
    }

    //
    //	Read offsets.
    //
    op=malloc((entries+1)*sizeof(unsigned char**));
    if( !op ) {
	printf("Can't malloc %d entries\n",entries);
	exit(-1);
    }
    for( i=0; i<entries; ++i ) {
	op[i]=buf+FetchLE32(cp);
	DebugLevel3("Offset\t%d\n",op[i]);
    }
    op[i]=buf+stat_buf.st_size;

    ArchiveOffsets=op;
    ArchiveBuffer=buf;

    return 0;
}

/**
**	Extract/uncompress entry.
**
**	@param cp	Pointer to compressed entry
**	@param lenp	Return pointer of length of the entry
**
**	@return		Pointer to uncompressed entry
*/
unsigned char* ExtractEntry(unsigned char* cp,int* lenp)
{
    unsigned char* dp;
    unsigned char* dest;
    int uncompressed_length;
    int flags;

    uncompressed_length=FetchLE32(cp);
    flags=uncompressed_length>>24;
    uncompressed_length&=0x00FFFFFF;
    DebugLevel3("Entry length %8d flags %02x\t",uncompressed_length,flags);

    dp=dest=malloc(uncompressed_length);
    if( !dest ) {
	printf("Can't malloc %d\n",uncompressed_length);
	exit(-1);
    }

    if( flags==0x20 ) {
	unsigned char buf[4096];
	unsigned char* ep;
	int bi;

	DebugLevel3("Compressed entry\n");

	bi=0;
	memset(buf,0,sizeof(buf));
	ep=dp+uncompressed_length;

	// FIXME: If the decompression is too slow, optimise this loop :->
	while( dp<ep ) {
	    int i;
	    int bflags;

	    bflags=FetchByte(cp);
	    DebugLevel3("Ctrl %02x ",bflags);
	    for( i=0; i<8; ++i ) {
		int j;
		int o;

		if( bflags&1 ) {
		    j=FetchByte(cp);
		    *dp++=j;
		    buf[bi++&0xFFF]=j;
		    DebugLevel3("=%02x",j);
		} else {
		    o=FetchLE16(cp);
		    DebugLevel3("*%d,%d",o>>12,o&0xFFF);
		    j=(o>>12)+3;
		    o&=0xFFF;
		    while( j-- ) {
			buf[bi++&0xFFF]=*dp++=buf[o++&0xFFF];
			if( dp==ep ) {
			    break;
			}
		    }
		}
		if( dp==ep ) {
		    break;
		}
		bflags>>=1;
	    }
	    DebugLevel3("\n");
	}
	//if( dp!=ep ) printf("%p,%p %d\n",dp,ep,dp-dest);
    } else if( flags==0x00 ) {
	DebugLevel3("Uncompressed entry\n");
	memcpy(dest,cp,uncompressed_length);
    } else {
	printf("Unknown flags %x\n",flags);
	exit(-1);
    }

    if( lenp ) {			// return resulting length
	*lenp=uncompressed_length;
    }

    return dest;
}

/**
**	Close the archive file.
*/
int CloseArchive(void)
{
    free(ArchiveBuffer);
    free(ArchiveOffsets);
    ArchiveBuffer=0;
    ArchiveOffsets=0;

    return 0;
}

//----------------------------------------------------------------------------
//	Palette
//----------------------------------------------------------------------------

/**
**	Convert palette.
**
**	@param pal	Pointer to palette
**
**	@return		Pointer to palette
*/
unsigned char* ConvertPalette(unsigned char* pal)
{
    int i;

    for( i=0; i<768; ++i ) {		// PNG needs 0-256
	pal[i]<<=2;
    }

    return pal;
}

/**
**	Convert rgb to my format.
*/
int ConvertRgb(char* file,int rgbe)
{
    unsigned char* rgbp;
    char buf[1024];
    FILE* f;
    int i;
    int l;

    rgbp=ExtractEntry(ArchiveOffsets[rgbe],&l);

    //
    //	Generate RGB File
    //
    sprintf(buf,"%s/%s.rgb",Dir,file);
    f=fopen(buf,"wb");
    if( !f ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=fwrite(rgbp,1,l,f) ) {
	printf("Can't write %d bytes\n",l);
    }

    fclose(f);
    //
    //	Generate GIMP palette
    //
    sprintf(buf,"%s/%s.gimp",Dir,file);
    f=fopen(buf,"wb");
    if( !f ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    fprintf(f,"GIMP Palette\n# FreeCraft %c%s -- GIMP Palette file\n"
	    ,toupper(*file),file+1);

    for( i=0; i<256; ++i ) {
	fprintf(f,"%d %d %d\t#%d\n"
		,rgbp[i*3]*4,rgbp[i*3+1]*4,rgbp[i*3+2]*4,i);
    }

    free(rgbp);

    return 0;
}

//----------------------------------------------------------------------------
//	Tileset
//----------------------------------------------------------------------------

/**
**	Count used mega tiles for map.
*/
int CountUsedTiles(const unsigned char* map,const unsigned char* mega
	,int* map2tile)
{
    int i;
    int j;
    int used;
    const char* tp;
    int img2tile[0x9E0];

    DebugLevel1(__FUNCTION__":\n");
    memset(map2tile,0,sizeof(map2tile));

    //
    //	Build conversion table.
    //
    for( i=0; i<0x9E; ++i ) {
	tp=map+i*42;
	DebugLevel2("%02X:",i);
	for( j=0; j<0x10; ++j ) {
	    DebugLevel2("%04X ",AccessLE16(tp+j*2));
	    map2tile[(i<<4)|j]=AccessLE16(tp+j*2);
	}
	DebugLevel2("\n");
    }

    //
    //	Mark all used mega tiles.
    //
    used=0;
    for( i=0; i<0x9E0; ++i ) {
	if( !map2tile[i] ) {
	    continue;
	}
	for( j=0; j<used; ++j ) {
	    if( img2tile[j]==map2tile[i] ) {
		break;
	    }
	}
	if( j==used ) {
	    //
	    //	Check unique mega tiles.
	    //
	    for( j=0; j<used; ++j ) {
		if( !memcmp(mega+img2tile[j]*32
			    ,mega+map2tile[i]*32,32) ) {
		    break;
		}
	    }
	    if( j==used ) {
		img2tile[used++]=map2tile[i];
	    }
	}
    }
    DebugLevel1("Used mega tiles %d\n",used);
#if 0
    for( i=0; i<used; ++i ) {
	if( !(i%16) ) {
	    DebugLevel1("\n");
	}
	DebugLevel1("%3d ",img2tile[i]);
    }
    DebugLevel1("\n");
#endif

    return used;
}

/**
**	Convert for ccl.
*/
void SaveCCL(const char* name,unsigned char* map,const int* map2tile)
{
    int i;
    char* cp;
    FILE* f;
    char file[1024];
    char tileset[1024];

    f=stdout;
    // FIXME: open file!

    if( (cp=strrchr(name,'/')) ) {	// remove leading path
	++cp;
    } else {
	cp=(char*)name;
    }
    strcpy(file,cp);
    strcpy(tileset,cp);
    if( (cp=strrchr(tileset,'.')) ) {	// remove suffix
	*cp='\0';
    }

    fprintf(f,"(tileset Tileset%c%s \"%s\" \"%s\"\n"
	,toupper(*tileset),tileset+1,tileset,file);

    fprintf(f,"  #(");
    for( i=0; i<0x9E0; ++i ) {
	if( i&15 ) {
	    fprintf(f," ");
	} else if( i ) {
	    fprintf(f,"\t; %03X\n    ",i-16);
	}
	fprintf(f,"%3d",map2tile[i]);
    }

    fprintf(f,"  ))\n");

    // fclose(f);
}

/**
**	Decode a minitile into the image.
*/
void DecodeMiniTile(unsigned char* image,int ix,int iy,int iadd
	,unsigned char* mini,int index,int flipx,int flipy)
{
    int x;
    int y;

    DebugLevel3(__FUNCTION__": index %d\n",index);
    for( y=0; y<8; ++y ) {
	for( x=0; x<8; ++x ) {
	    image[(y+iy*8)*iadd+ix*8+x]=mini[index+
		(flipy ? (8-y) : y)*8+(flipx ? (8-x) : x)];
	}
    }
}

/**
**	Convert tiles into image.
*/
unsigned char* ConvertTile(unsigned char* mini,const char* mega,int msize
	,const char* map,int *wp,int *hp)
{
    unsigned char* image;
    const unsigned short* mp;
    int height;
    int width;
    int i;
    int x;
    int y;
    int offset;
    int numtiles;

    DebugLevel1("Tiles in mega %d\t",msize/32);
    numtiles=msize/32;

    width=TILE_PER_ROW*32;
    height=((numtiles+TILE_PER_ROW-1)/TILE_PER_ROW)*32;
    DebugLevel1("Image %dx%d\n",width,height);
    image=malloc(height*width);
    memset(image,0,height*width);

    for( i=0; i<numtiles; ++i ) {
	//mp=(const unsigned short*)(mega+img2tile[i]*32);
	mp=(const unsigned short*)(mega+i*32);
	if( i<16 ) {
	    for( y=0; y<32; ++y ) {
		offset=i*32*32+y*32;
		memcpy(image+(i%TILE_PER_ROW)*32
			+(((i/TILE_PER_ROW)*32)+y)*width
			,mini+offset,32);
	    }
	} else {
	    for( y=0; y<4; ++y ) {
		for( x=0; x<4; ++x ) {
		    offset=ConvertLE16(mp[x+y*4]);
		    DecodeMiniTile(image
			,x+((i%TILE_PER_ROW)*4),y+(i/TILE_PER_ROW)*4,width
			,mini,(offset&0xFFFC)*16,offset&2,offset&1);
		}
	    }
	}
    }

    *wp=width;
    *hp=height;

    return image;
}

/**
**	Convert a tileset to my format.
*/
int ConvertTileset(char* file,int pale,int mege,int mine,int mape)
{
    unsigned char* palp;
    unsigned char* megp;
    unsigned char* minp;
    unsigned char* mapp;
    unsigned char* image;
    int w;
    int h;
    int megl;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    megp=ExtractEntry(ArchiveOffsets[mege],&megl);
    minp=ExtractEntry(ArchiveOffsets[mine],NULL);
    mapp=ExtractEntry(ArchiveOffsets[mape],NULL);

    image=ConvertTile(minp,megp,megl,mapp,&w,&h);

    free(megp);
    free(minp);
    free(mapp);

    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,TILESET_PATH,file);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Graphics
//----------------------------------------------------------------------------

/**
**	Decode a entry(frame) into image.
*/
void DecodeGfxEntry(int index,unsigned char* start
	,unsigned char* image,int ix,int iy,int iadd)
{
    unsigned char* bp;
    unsigned char* sp;
    unsigned char* dp;
    int xoff;
    int yoff;
    int width;
    int height;
    int offset;
    unsigned char* rows;
    int h;
    int w;
    int ctrl;

    bp=start+index*8;
    xoff=FetchByte(bp);
    yoff=FetchByte(bp);
    width=FetchByte(bp);
    height=FetchByte(bp);
    offset=FetchLE32(bp);

    DebugLevel3("%2d: +x %2d +y %2d width %2d height %2d offset %d\n"
	,index,xoff,yoff,width,height,offset);

    rows=start+offset-6;
    dp=image+xoff-ix+(yoff-iy)*iadd;

    for( h=0; h<height; ++h ) {
	DebugLevel3("%2d: row-offset %2d\t",index,AccessLE16(rows+h*2));
	sp=rows+AccessLE16(rows+h*2);
	for( w=0; w<width; ) {
	    ctrl=*sp++;
	    DebugLevel3("%02X",ctrl);
	    if( ctrl&0x80 ) {		// transparent
		ctrl&=0x7F;
		DebugLevel3("-%d,",ctrl);
		memset(dp+h*iadd+w,255,ctrl);
		w+=ctrl;
	    } else if( ctrl&0x40 ) {	// repeat
		ctrl&=0x3F;
		DebugLevel3("*%d,",ctrl);
		memset(dp+h*iadd+w,*sp++,ctrl);
		w+=ctrl;
	    } else {			// set pixels
		ctrl&=0x3F;
		DebugLevel3("=%d,",ctrl);
		memcpy(dp+h*iadd+w,sp,ctrl);
		sp+=ctrl;
		w+=ctrl;
	    }
	}
	//dp[h*iadd+width-1]=0;
	DebugLevel3("\n");
    }
}

/**
**	Decode a entry(frame) into image.
*/
void DecodeGfuEntry(int index,unsigned char* start
	,unsigned char* image,int ix,int iy,int iadd)
{
    unsigned char* bp;
    unsigned char* sp;
    unsigned char* dp;
    int i;
    int xoff;
    int yoff;
    int width;
    int height;
    int offset;

    bp=start+index*8;
    xoff=FetchByte(bp);
    yoff=FetchByte(bp);
    width=FetchByte(bp);
    height=FetchByte(bp);
    offset=FetchLE32(bp);
    if( offset<0 ) {			// High bit of width
	offset&=0x7FFFFFFF;
	width+=256;
    }
    
    DebugLevel3("%2d: +x %2d +y %2d width %2d height %2d offset %d\n"
	,index,xoff,yoff,width,height,offset);

    sp=start+offset-6;
    dp=image+xoff-ix+(yoff-iy)*iadd;
    for( i=0; i<height; ++i ) {
	memcpy(dp,sp,width);
	dp+=iadd;
	sp+=width;
    }
}
/**
**	Convert graphics into image.
*/
unsigned char* ConvertGraphic(int gfx,unsigned char* bp,int *wp,int *hp)
{
    int i;
    int count;
    int length;
    int max_width;
    int max_height;
    int minx;
    int miny;
    int best_width;
    int best_height;
    unsigned char* image;
    int IPR;

    count=FetchLE16(bp);
    max_width=FetchLE16(bp);
    max_height=FetchLE16(bp);

    DebugLevel0("Entries %2d Max width %3d height %3d, ",count
	    ,max_width,max_height);

    // Find best image size
    minx=999;
    miny=999;
    best_width=0;
    best_height=0;
    for( i=0; i<count; ++i ) {
	unsigned char* p;
	int xoff;
	int yoff;
	int width;
	int height;

	p=bp+i*8;
	xoff=FetchByte(p);
	yoff=FetchByte(p);
	width=FetchByte(p);
	height=FetchByte(p);
	if( FetchLE32(p)&0x80000000 ) {	// high bit of width
	    width+=256;
	}
	if( xoff<minx ) minx=xoff;
	if( yoff<miny ) miny=yoff;
	if( xoff+width>best_width ) best_width=xoff+width;
	if( yoff+height>best_height ) best_height=yoff+height;
    }
    // FIXME: the image isn't centered!!

#if 0
    // Taken out, must be rewritten.
    if( max_width-best_width<minx ) {
	minx=max_width-best_width;
	best_width-=minx;
    } else {
	best_width=max_width-minx;
    }
    if( max_height-best_height<miny ) {
	miny=max_height-best_height;
	best_height-=miny;
    } else {
	best_height=max_width-miny;
    }

    //best_width-=minx;
    //best_height-=miny;
#endif

    DebugLevel0("Best image size %3d, %3d\n",best_width,best_height);

    minx=0;
    miny=0;

    if( gfx ) {
	best_width=max_width;
	best_height=max_height;
	IPR=5;				// st*rcr*ft 17!
	if( count<IPR ) {		// images per row !!
	    IPR=1;
	    length=count;
	} else {
	    length=((count+IPR-1)/IPR)*IPR;
	}
    } else {
	max_width=best_width;
	max_height=best_height;
	IPR=1;
	length=count;
    }

    image=malloc(best_width*best_height*length);

    //	Image:	0, 1, 2, 3, 4,
    //		5, 6, 7, 8, 9, ...
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    // Set all to transparent.
    memset(image,255,best_width*best_height*length);

    if( gfx ) {
	for( i=0; i<count; ++i ) {
	    DecodeGfxEntry(i,bp
		,image+best_width*(i%IPR)+best_height*best_width*IPR*(i/IPR)
		,minx,miny,best_width*IPR);
	}
    } else {
	for( i=0; i<count; ++i ) {
	    DecodeGfuEntry(i,bp
		,image+best_width*(i%IPR)+best_height*best_width*IPR*(i/IPR)
		,minx,miny,best_width*IPR);
	}
    }

    *wp=best_width*IPR;
    *hp=best_height*(length/IPR);

    return image;
}

/**
**	Convert a graphic to my format.
*/
int ConvertGfx(char* file,int pale,int gfxe)
{
    unsigned char* palp;
    unsigned char* gfxp;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    gfxp=ExtractEntry(ArchiveOffsets[gfxe],NULL);

    image=ConvertGraphic(1,gfxp,&w,&h);

    free(gfxp);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,UNIT_PATH,file);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

/**
**	Convert a uncompressed graphic to my format.
*/
int ConvertGfu(char* file,int pale,int gfue)
{
    unsigned char* palp;
    unsigned char* gfup;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    gfup=ExtractEntry(ArchiveOffsets[gfue],NULL);

    image=ConvertGraphic(0,gfup,&w,&h);

    free(gfup);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,UNIT_PATH,file);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Puds
//----------------------------------------------------------------------------

/**
**	Convert pud to my format.
*/
int ConvertPud(char* file,int pude)
{
#if 1
    // FIXME: don't know why this didn't work?
    // FIXME: Now it works, mystic :)

    unsigned char* pudp;
    char buf[1024];
    gzFile gf;
    int l;

    pudp=ExtractEntry(ArchiveOffsets[pude],&l);

    sprintf(buf,"%s/%s/%s.pud.gz",Dir,PUD_PATH,file);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=gzwrite(gf,pudp,l) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(pudp);

    gzclose(gf);
    return 0;
#else
    unsigned char* pudp;
    char buf[1024];
    FILE* f;
    int l;

    pudp=ExtractEntry(ArchiveOffsets[pude],&l);

    // FIXME: don't know why this didn't ?
    sprintf(buf,"%s/%s/%s.pud",Dir,PUD_PATH,file);
    f=fopen(buf,"wb");
    if( !f ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=fwrite(pudp,1,l,f) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(pudp);

    fclose(f);
    return 0;
#endif
}

//----------------------------------------------------------------------------
//	Font
//----------------------------------------------------------------------------

/**
**	Convert font into image.
*/
unsigned char* ConvertFnt(unsigned char* start,int *wp,int *hp)
{
    int i;
    int count;
    int max_width;
    int max_height;
    int width;
    int height;
    int w;
    int h;
    int xoff;
    int yoff;
    unsigned char* bp;
    unsigned char* dp;
    unsigned char* image;
    unsigned int* offsets;

    bp=start+5;				// skip "FONT "
    count=FetchByte(bp)-32;
    max_width=FetchByte(bp);
    max_height=FetchByte(bp);

    DebugLevel0("Font: count %d max-width %2d max-height %2d\n"
	    ,count,max_width,max_height);

    offsets=malloc(count*sizeof(u_int32_t));
    for( i=0; i<count; ++i ) {
	offsets[i]=FetchLE32(bp);
	DebugLevel3("%03d: offset %d\n",i,offsets[i]);
    }

    image=malloc(max_width*max_height*count);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    memset(image,255,max_width*max_height*count);

    for( i=0; i<count; ++i ) {
	if( !offsets[i] ) {
	    DebugLevel3("%03d: unused\n",i);
	    continue;
	}
	bp=start+offsets[i];
	width=FetchByte(bp);
	height=FetchByte(bp);
	xoff=FetchByte(bp);
	yoff=FetchByte(bp);

	DebugLevel3("%03d: width %d height %d xoff %d yoff %d\n"
		,i,width,height,xoff,yoff);

	dp=image+xoff+yoff*max_width+i*(max_width*max_height);
	h=w=0;
	for( ;; ) {
	    int ctrl;
	    
	    ctrl=FetchByte(bp);
	    DebugLevel3("%d,%d ",ctrl>>3,ctrl&7);
	    w+=(ctrl>>3)&0x1F;
	    if( w>=width ) {
		DebugLevel3("\n");
		w-=width;
		++h;
		if( h>=height ) {
		    break;
		}
	    }
	    dp[h*max_width+w]=ctrl&0x07;
	    ++w;
	    if( w>=width ) {
		DebugLevel3("\n");
		w-=width;
		++h;
		if( h>=height ) {
		    break;
		}
	    }
	}
    }
    

    free(offsets);

    *wp=max_width;
    *hp=max_height*count;

    return image;
}

/**
**	Convert a font to my format.
*/
int ConvertFont(char* file,int pale,int fnte)
{
    unsigned char* palp;
    unsigned char* fntp;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    fntp=ExtractEntry(ArchiveOffsets[fnte],NULL);

    image=ConvertFnt(fntp,&w,&h);

    free(fntp);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,FONT_PATH,file);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Image
//----------------------------------------------------------------------------

/**
**	Convert image into image.
*/
unsigned char* ConvertImg(unsigned char* bp,int *wp,int *hp)
{
    int width;
    int height;
    unsigned char* image;

    width=FetchLE16(bp);
    height=FetchLE16(bp);
    
    DebugLevel0("Image: width %3d height %3d\n",width,height);

    image=malloc(width*height);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    memcpy(image,bp,width*height);

    *wp=width;
    *hp=height;

    return image;
}

/**
**	Convert a image to my format.
*/
int ConvertImage(char* file,int pale,int imge)
{
    unsigned char* palp;
    unsigned char* imgp;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    imgp=ExtractEntry(ArchiveOffsets[imge],NULL);

    image=ConvertImg(imgp,&w,&h);

    free(imgp);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,GRAPHIC_PATH,file);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Cursor
//----------------------------------------------------------------------------

/**
**	Convert cursor into image.
*/
unsigned char* ConvertCur(unsigned char* bp,int *wp,int *hp)
{
    int i;
    int hotx;
    int hoty;
    int width;
    int height;
    unsigned char* image;

    hotx=FetchLE16(bp);
    hoty=FetchLE16(bp);
    width=FetchLE16(bp);
    height=FetchLE16(bp);
    
    DebugLevel0("Cursor: hotx %d hoty %d width %d height %d\n"
	    ,hotx,hoty,width,height);

    image=malloc(width*height);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    for( i=0; i<width*height; ++i ) {
	image[i]=bp[i] ? bp[i] : 255;
    }

    *wp=width;
    *hp=height;

    return image;
}

/**
**	Convert a cursor to my format.
*/
int ConvertCursor(char* file,int pale,int cure)
{
    unsigned char* palp;
    unsigned char* curp;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    curp=ExtractEntry(ArchiveOffsets[cure],NULL);

    image=ConvertCur(curp,&w,&h);

    free(curp);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,CURSOR_PATH,file);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Wav
//----------------------------------------------------------------------------

/**
**	Convert pud to my format.
*/
int ConvertWav(char* file,int wave)
{
    unsigned char* wavp;
    char buf[1024];
    gzFile gf;
    int l;

    wavp=ExtractEntry(ArchiveOffsets[wave],&l);

    sprintf(buf,"%s/%s/%s.wav.gz",Dir,SOUND_PATH,file);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=gzwrite(gf,wavp,l) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(wavp);

    gzclose(gf);
    return 0;
}

//----------------------------------------------------------------------------
//	Text
//----------------------------------------------------------------------------

/**
**	Convert text to my format.
*/
int ConvertText(char* file,int txte)
{
    unsigned char* txtp;
    char buf[1024];
    gzFile gf;
    int l;

    txtp=ExtractEntry(ArchiveOffsets[txte],&l);

    sprintf(buf,"%s/%s/%s.txt.gz",Dir,TEXT_PATH,file);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=gzwrite(gf,txtp,l) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(txtp);

    gzclose(gf);
    return 0;
}

/**
**	Convert text to my format.
*/
int SetupNames(char* file,int txte)
{
    unsigned char* txtp;
    const unsigned short* mp;
    int l;
    int i;
    int n;

    txtp=ExtractEntry(ArchiveOffsets[txte],&l);
    mp=(const unsigned short*)txtp;

    n=ConvertLE16(mp[0]);
    for( i=1; i<n; ++i ) {
	DebugLevel3("%d %x ",i,ConvertLE16(mp[i]));
	DebugLevel3("%s\n",txtp+ConvertLE16(mp[i]));
	if( i<sizeof(UnitNames)/sizeof(*UnitNames) ) {
	    UnitNames[i]=strdup(txtp+ConvertLE16(mp[i]));
	}
    }

    free(txtp);
    return 0;
}

/**
**	Parse string.
*/
char* ParseString(char* input)
{
    static char buf[1024];
    char* dp;
    char* sp;
    char* tp;
    int i;

    for( sp=input,dp=buf; *sp; ) {
	if( *sp=='%' ) {
	    i=strtol(sp+1,&sp,0);
	    tp=UnitNames[i];
	    while( *tp ) {
		*dp++=tolower(*tp++);
	    }
	    continue;
	}
	*dp++=*sp++;
    }
    *dp='\0';

    return buf;
}

//----------------------------------------------------------------------------
//	Main loop
//----------------------------------------------------------------------------

/**
**	Display the usage.
*/
void Usage(const char* name)
{
    printf("wartool for FreeCraft V" VERSION ", (c) 1999,2000 by the FreeCraft Project\n\
Usage: %s [-e] archive-directory [destination-directory]\n\
\t-e\tThe archive are expansion compatible\n\
\t-n\tThe archive is not expansion compatible\n\
archive-directory\tDirectory which includes the archives maindat.war...\n\
destination-directory\tDirectory where the extracted files are placed.\n"
    ,name);
}

/**
**	Main
*/
int main(int argc,char** argv)
{
    int i;
    char* archivedir;
    char buf[1024];
    struct stat stat_buf;
    int expansion_cd;
    int a;

    a=1;
    expansion_cd=0;
    while( argc>=2 ) {
	if( !strcmp(argv[a],"-e") ) {
	    expansion_cd=1;
	    ++a;
	    --argc;
	    continue;
	}
	if( !strcmp(argv[a],"-n") ) {
	    expansion_cd=-1;
	    ++a;
	    --argc;
	    continue;
	}
	if( !strcmp(argv[a],"-h") ) {
	    Usage(argv[0]);
	    ++a;
	    --argc;
	    continue;
	}
	break;
    }

    if( argc!=2 && argc!=3 ) {
	Usage(argv[0]);
	exit(-1);
    }

    archivedir=argv[a];
    if( argc==3 ) {
	Dir=argv[a+1];
    } else {
	Dir="data";
    }

    // alamo.pud is not on Expansion CD
    sprintf(buf,"%s/../alamo.pud",archivedir);
    if ( expansion_cd==-1 || !stat(buf,&stat_buf)) {
	expansion_cd=0;
    } else {
	expansion_cd=1;
    }

    DebugLevel2("Extract from \"%s\" to \"%s\"\n",archivedir, Dir);
    for( i=0; i<sizeof(Todo)/sizeof(*Todo); ++i ) {
	// Should only be on the expansion cd
	DebugLevel3("%s\n",Todo[i].File);
	if (!expansion_cd && Todo[i].Version==2 ) {
	    continue;
	}
	switch( Todo[i].Type ) {
	    case F:
		sprintf(buf,"%s/%s",archivedir,Todo[i].File);
		DebugLevel2("Archive \"%s\"\n",buf);
		if( ArchiveBuffer ) {
		    CloseArchive();
		}
		OpenArchive(buf,Todo[i].Arg1);
		break;
	    case R:
		ConvertRgb(Todo[i].File,Todo[i].Arg1);
		break;
	    case T:
		ConvertTileset(Todo[i].File,Todo[i].Arg1,Todo[i].Arg2
			,Todo[i].Arg3,Todo[i].Arg4);
		break;
	    case G:
		ConvertGfx(ParseString(Todo[i].File),Todo[i].Arg1,Todo[i].Arg2);
		break;
	    case U:
		ConvertGfu(Todo[i].File,Todo[i].Arg1,Todo[i].Arg2);
		break;
	    case P:
		ConvertPud(Todo[i].File,Todo[i].Arg1);
		break;
	    case N:
		ConvertFont(Todo[i].File,2,Todo[i].Arg1);
		break;
	    case I:
		ConvertImage(Todo[i].File,Todo[i].Arg1,Todo[i].Arg2);
		break;
	    case C:
		ConvertCursor(Todo[i].File,Todo[i].Arg1,Todo[i].Arg2);
		break;
	    case W:
		ConvertWav(Todo[i].File,Todo[i].Arg1);
		break;
	    case X:
		ConvertText(Todo[i].File,Todo[i].Arg1);
		break;
	    case S:
		SetupNames(Todo[i].File,Todo[i].Arg1);
		break;
	    default:
		break;
	}
    }

    return 0;
}
