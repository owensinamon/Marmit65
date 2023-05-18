PRAGMA encoding = "UTF-8";
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Ingredients" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"Nom"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Famille" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"Nom"	TEXT,
	"Image"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Recettes" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"Nom"	TEXT,
	"Image"	TEXT,
	"Nombre de personnes"	INTEGER,
	"Cuisson"	INTEGER,
	"Difficulte"	INTEGER,
	"ID_Famille"	INTEGER,
	FOREIGN KEY("ID_Famille") REFERENCES "Famille"("ID"),
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "IngredientsDeRecette" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"ID_recettes"	INTEGER,
	"ID_ingredients"	INTEGER,
	"Quantite"	REAL,
	"Unite"	TEXT,
	FOREIGN KEY("ID_recettes") REFERENCES "Recettes"("ID"),
	FOREIGN KEY("ID_ingredients") REFERENCES "Ingredients"("ID"),
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "EtapesDeRecette" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"ID_recettes"	INTEGER,
	"Numero"	INTEGER,
	"Descriptif"	TEXT,
	FOREIGN KEY("ID_recettes") REFERENCES "Recettes"("ID"),
	PRIMARY KEY("ID" AUTOINCREMENT)
);
INSERT INTO "Ingredients" ("ID","Nom") VALUES (1,'Salade verte'),
 (2,'Tomates cerises'),
 (3,'Chèvre frais'),
 (4,'Pain de mie'),
 (5,'Miel'),
 (6,'Vinaigrette'),
 (7,'Boeuf'),
 (8,'Carottes'),
 (9,'Oignons'),
 (10,'Ail'),
 (11,'Lardons'),
 (12,'Vin rouge'),
 (13,'Bouquet garni'),
 (14,'Pâte brisée'),
 (15,'Pommes'),
 (16,'Sucre'),
 (17,'Cannelle'),
 (18,'Beurre'),
 (19,'Tomates'),
 (20,'Oignons'),
 (21,'Ail'),
 (22,'Huile d''olive'),
 (23,'Bouquet garni'),
 (24,'Vin blanc'),
 (25,'Levure chimique'),
 (26,'Sel'),
 (27,'Poivre'),
 (28,'Menthe'),
 (29,'Citron vert'),
 (30,'Vanille en poudre'),
 (31,'Eau gazeuse'),
 (32,'Rhum'),
 (33,'Pâte feuilletée'),
 (34,'Fromage'),
 (35,'Oeuf'),
 (36,'Lait'),
 (37,'Crème fraîche'),
 (38,'Mascarpone'),
 (39,'Sucre vanillé'),
 (40,'Blanc d''oeuf'),
 (41,'Vanille'),
 (42,'Tequila'),
 (43,'Curaçao'),
 (44,'Farine');
INSERT INTO "Famille" ("ID","Nom","Image") VALUES (1,'Entrees','image\famille\entrees.png'),
 (2,'Plats','image\famille\plats.png'),
 (3,'Desserts','image\famille\desserts.png'),
 (4,'Sauces','image\famille\sauces.png'),
 (5,'Boissons','image\famille\boissons.png'),
 (6,'Apéritifs','image\famille\aperitifs.png'),
 (7,'Autres','image\famille\autres.png');
INSERT INTO "Recettes" ("ID","Nom","Image","Nombre de personnes","Cuisson","Difficulte","ID_Famille") VALUES (1,'Salade de chèvre chaud','image\recettes\salade_chevre.png',4,0,1,1),
 (2,'Boeuf bourguignon','image\recettes\boeuf_bourguignon.png',6,180,3,2),
 (3,'Tarte aux pommes','image\recettes\tarte_pommes.png',8,50,2,3),
 (4,'Sauce tomate','image\recettes\sauce_tomate.png',4,30,1,4),
 (5,'Mojito','image\recettes\mojito.png',2,0,2,5),
 (6,'Feuilletés au fromage','image\recettes\feuilletes_fromage.png',6,20,2,6),
 (7,'Crème brûlée','image\recettes\creme_brulee.png',4,45,3,3),
 (8,'Blue Margarita','image\recettes\blue-margarita.jpg',1,0,1,5),
 (9,'Crêpe au four finlandaise (Pannukakku)','image\recettes\pannukakku.png',4,20,2,3);
INSERT INTO "IngredientsDeRecette" ("ID", "ID_recettes", "ID_ingredients", "Quantite", "Unite") VALUES (1, 1, 1, 1.0, 'salade'),
 (2,1,2,150.0,'g'),
 (3,1,3,150.0,'g'),
 (4,1,4,4.0,'tranches'),
 (5,1,5,1.0,'cuillière à soupe'),
 (6,1,6,1.0,'portion'),
 (7,2,7,800.0,'g'),
 (8,2,8,4.0,''),
 (9,2,9,2.0,''),
 (10,2,10,2.0,'gousses'),
 (11,2,11,150.0,'g'),
 (12,2,12,750.0,'ml'),
 (13,2,13,1.0,''),
 (14,3,14,1.0,'pâte'),
 (15,3,15,6.0,''),
 (16,3,16,100.0,'g'),
 (17,3,17,1.0,'cuillère à café'),
 (18,3,18,25.0,'g'),
 (19,4,19,800.0,'g'),
 (20,4,20,1.0,''),
 (21,4,21,2.0,'gousses'),
 (22,4,22,1.0,'cuillère à soupe'),
 (23,4,23,1.0,''),
 (24,4,24,25.0,'cl'),
 (25,4,16,1.0,'cuillère à café'),
 (26,4,26,1.0,'cuillère à café'),
 (27,4,27,1.0,'cuillère à café'),
 (28,5,28,10.0,'feuilles'),
 (29,5,29,1.0,''),
 (30,5,16,1.0,'cuillère à café'),
 (31,5,31,1.0,'verre'),
 (32,5,32,4.0,'cl'),
 (33,6,33,1.0,'pâte'),
 (34,6,34,200.0,'g'),
 (35,6,35,1.0,''),
 (36,6,36,25.0,'cl'),
 (37,7,37,25.0,'cl'),
 (38,7,36,25.0,'cl'),
 (39,7,35,3.0,''),
 (40,7,16,100.0,'g'),
 (41,7,41,1.0,'gousse'),
 (42,8,42,4,'cl'),
 (43,8,43,2,'cl'),
 (44,8,29,2,'cl'),
 (45,9,44,140,'g'),
 (46,9,16,100,'g'),
 (47,9,36,40,'cl'),
 (48,9,35,1,''),
 (49,9,18,50,'g'),
 (50,9,25,0.5,'sachet'),
 (51,9,26,1,'cuillère à café'),
 (52,9,30,1,'cuillère à café'),
 (53,9,37,25,'cl'),
 (54,9,38,150,'g'),
 (55,9,39,2,'sachets');
INSERT INTO "EtapesDeRecette" ("ID","ID_recettes","Numero","Descriptif") VALUES (1,1,1,'Laver et couper les légumes'),
 (2,1,2,'Faire griller les tranches de pain de mie'),
 (3,1,3,'Disposer la salade, les tomates et le chèvre sur les tranches de pain'),
 (4,1,4,'Arroser de miel et de vinaigrette'),
 (5,1,5,'Passer sous le grill pendant 2-3 minutes'),
 (6,2,1,'Couper le boeuf en cubes'),
 (7,2,2,'Éplucher et couper les carottes et les oignons'),
 (8,2,3,'Faire revenir les lardons dans une cocotte'),
 (9,2,4,'Ajouter les légumes et l''ail dans la cocotte et faire dorer'),
 (10,2,5,'Ajouter le boeuf dans la cocotte et faire dorer'),
 (11,2,6,'Verser le vin rouge et ajouter le bouquet garni'),
 (12,2,7,'Laisser mijoter à feu doux pendant 2h30'),
 (13,3,1,'Éplucher et couper les pommes en quartiers'),
 (14,3,2,'Étaler la pâte dans un moule à tarte'),
 (15,3,3,'Disposer les pommes sur la pâte'),
 (16,3,4,'Saupoudrer de sucre et de cannelle'),
 (17,3,5,'Faire cuire à 180°C pendant 30 minutes'),
 (18,4,1,'Éplucher et couper les oignons et l''ail'),
 (19,4,2,'Faire revenir les oignons et l''ail dans une cocotte'),
 (20,4,3,'Ajouter les tomates et le bouquet garni'),
 (21,4,4,'Laisser mijoter à feu doux pendant 1h'),
 (22,4,5,'Ajouter le vin blanc, le sucre, le sel et le poivre'),
 (23,4,6,'Laisser mijoter à feu doux pendant 1h'),
 (24,4,7,'Passer au mixeur'),
 (25,4,8,'Laisser mijoter à feu doux pendant 1h'),
 (26,4,9,'Passer au mixeur'),
 (27,5,1,'Mettre les feuilles de menthe dans un verre'),
 (28,5,2,'Presser le citron vert dans le verre'),
 (29,5,3,'Ajouter le sucre'),
 (30,5,4,'Ajouter le rhum'),
 (31,5,5,'Remplir le verre d''eau gazeuse'),
 (32,5,6,'Mélanger le tout'),
 (33,6,1,'Étaler la pâte feuilletée dans un moule à tarte'),
 (34,6,2,'Couper le fromage en fines tranches'),
 (35,6,3,'Disposer les tranches de fromage sur la pâte'),
 (36,6,4,'Badigeonner le tout d''oeuf battu'),
 (37,6,5,'Faire cuire à 180°C pendant 20 minutes'),
 (38,7,1,'Faire bouillir le lait'),
 (39,7,2,'Mélanger les jaunes d''oeufs et le sucre'),
 (40,7,3,'Ajouter la vanille'),
 (41,7,4,'Verser le lait bouillant sur le mélange'),
 (42,7,5,'Remettre le tout dans la casserole et faire cuire à feu doux en remuant sans arrêt'),
 (43,7,6,'Verser la crème dans des ramequins'),
 (44,7,7,'Laisser refroidir'),
 (45,7,8,'Passer au four à 180°C pendant 10 minutes'),
 (46,7,9,'Saupoudrer de sucre et passer sous le grill pendant 2 minutes'),
 (47,8,1,"Dans un shaker, versez la tequila, le curaçao et le jus d’un citron vert, rajoutez les glaçons et secouez énergiquement"),
 (48,8,2,"Versez le mélange en filtrant les glaçons dans un verre à Martini"),
 (49,9,1,"Préchauffez le four à 180 °C"),
 (50,9,2,"Dans un bol, mélangez la farine, le sucre, le sel et la levure"),
 (51,9,3,"Faites un puits, cassez l’œuf et mélangez"),
 (52,9,4,"Ajoutez le lait progressivement, puis la vanille en poudre et le beurre fondu"),
 (53,9,5,"Versez la pâte sur 1,50 cm d’épaisseur dans un moule"),
 (54,9,6,"Enfournez pour 10 min"),
 (55,9,7,"Recouvrez la surface d’une couche de sucre et poursuivez la cuisson 10 min"),
 (56,9,8,"Démoulez cette crêpe épaisse sur un plat de service"),
 (57,9,9,"Mélangez la crème et la mascarpone avec le sucre vanillé et placez au congélateur pour 30 min"),
 (58,9,10,"Fouettez la crème bien froide en chantilly"),
 (59,9,11,"Tartinez-en la crêpe");
COMMIT;
