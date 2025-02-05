"""
Fichier principal de l'application web Marmita.
Ce fichier contient toutes les routes de l'application web.
Il permet de lancer le serveur en local.
"""
import sqlite3
from bottle import request, route, run, view, static_file, response, error
# from bottle import get, post, request, route, run, view, static_file, response, error, redirect

DATABASE = 'database/marmita.db'

class Recette():
    """
    Classe qui représente une recette. Une recette possède les attributs suivants:
    - Id: l'identifiant de la recette dans la base de données
    - nom: le nom de la recette
    - image: l'image de la recette
    - preparation: le temps de préparation de la recette
    - cuisson: le temps de cuisson de la recette
    - nombre_de_personnes: le nombre de personnes pour lesquelles la recette est prévue
    - difficulte: la difficulté de la recette
    - ingredients: la liste des ingrédients de la recette
    - etapes: la liste des étapes de la recette
    - famille: la famille de la recette
    """

    def __init__(self, Id, nom, image, preparation, cuisson,
                 nbpers, diff, ingredients, etapes, famille):
        self.Id = Id
        self.nom = nom
        self.image = image
        self.preparation = preparation
        self.cuisson = cuisson
        self.nombre_de_personnes = nbpers
        self.difficulte = diff
        self.ingredients = ingredients
        self.etapes = etapes
        self.famille = famille


class Famille():
    """
    Classe qui représente une famille de recettes. Une famille possède les attributs suivants:
    - Id: l'identifiant de la famille dans la base de données
    - nom: le nom de la famille
    - image: l'image de la famille
    """

    def __init__(self, Id, nom, image):
        self.Id = Id
        self.nom = nom
        self.image = image


class Ingredient():
    """
    Classe qui représente un ingrédient. Un ingrédient possède les attributs suivants:
    - Id: l'identifiant de l'ingrédient dans la base de données
    - nom: le nom de l'ingrédient
    - quantite: la quantité de l'ingrédient
    - unite: l'unité de mesure de la quantité de l'ingrédient
    """

    def __init__(self, Id, nom, quantite, unite=None):
        self.Id = Id
        self.nom = nom
        self.quantite = quantite
        self.unite = unite


class Etape():
    """
    Classe qui re présente une étape de recette. Une étape possède les attributs suivants:
    - num: le numéro de l'étape dans la recette
    - texte: le texte de l'étape
    """

    def __init__(self, num, texte):
        self.num = num
        self.texte = texte


def open_sql(database=DATABASE):
    """
    Fonction qui permet d'ouvrir une connexion à la base de données.
    :return: le connecteur et le curseur de la base de données
    """
    conn = sqlite3.connect(database)
    cur = conn.cursor()
    return conn, cur


def close_sql(cur):
    """
    Fonction qui permet de fermer une connexion à la base de données.
    :param cur: le curseur de la base de données
    """
    cur.close()


@route('/style.css')
@view('static/css/style.css')
def style():
    response.content_type = "text/css"
    return {}


@route('/')
@view("template/accueil.tpl")
def accueil():
    conn, cur = open_sql()
    cur.execute("SELECT id, nom, image FROM famille")
    familles = []
    for row in cur:
        famille_id = row[0]
        famille_nom = row[1]
        famille_image = row[2]
        famille = Famille(famille_id, famille_nom, famille_image)
        familles.append(famille)
    close_sql(cur)
    return dict(listeFamille=familles)


@route('/famille', method='get')
@view("template/famille.tpl")
def famille():
    id = request.query.id  # type: ignore

    conn, cur = open_sql()

    # Requête SQL pour récupérer les recettes d'une famille
    cur.execute("SELECT * FROM recettes WHERE id_famille = ?", (id,))
    listeRecettes = []
    for row in cur:
        recette_id = row[0]
        recette_nom = row[1]
        recette_image = row[2]
        recette_famille = row[6]
        recette = Recette(recette_id, recette_nom, recette_image,
                          None, None, None, None, None, None, recette_famille)
        listeRecettes.append(recette)

    cur.execute("SELECT nom FROM famille WHERE ID = ?", (id,))
    nom = cur.fetchone()
    conn.commit()

    close_sql(cur)

    return dict(listeRecettes=listeRecettes, nom=nom[0], id=id)


# Affichage d'une recette
@route('/recettes/<id>')
@view("template/recette.tpl")
def recettes(id):
    conn, cur = open_sql()

    # Requête 1 (attributs de la table Recettes)
    cur.execute("SELECT * FROM Recettes WHERE ID=?", (id,))
    infos_recette = cur.fetchone()
    conn.commit()

    recette_id = infos_recette[0]
    recette_nom = infos_recette[1]
    recette_image = infos_recette[2]
    recette_nb_pers = infos_recette[3]
    recette_cuisson = infos_recette[4]
    recette_difficulte = infos_recette[5]
    recette_famille = infos_recette[6]

    # Requête pour récupérer le nom de la famille
    cur.execute("SELECT Nom FROM Famille WHERE ID=?", (recette_famille,))
    nom_famille = cur.fetchone()
    conn.commit()

    # Requête pour récupérer les ingrédients de la recette
    cur.execute("SELECT Ingredients.ID, Ingredients.Nom, Quantite, Unite FROM IngredientsDeRecette \
                INNER JOIN Ingredients ON Ingredients.ID=IngredientsDeRecette.ID_ingredients \
                WHERE ID_recettes=?", (recette_id,))
    liste_ingredients = []
    for row in cur:
        ingredient_id = row[0]
        ingredient_nom = row[1]
        ingredient_quantite = row[2]
        ingredient_unite = row[3]
        ingredient = Ingredient(
            ingredient_id, ingredient_nom, ingredient_quantite, ingredient_unite)
        liste_ingredients.append(ingredient)
    conn.commit()

    # Requête pour récupérer les étapes de la recette
    cur.execute("SELECT Numero, Descriptif FROM EtapesDeRecette \
                WHERE ID_recettes=?", (recette_id,))
    etapes_recette = []
    for row in cur:
        etape_num = row[0]
        etape_texte = row[1]
        etape = Etape(etape_num, etape_texte)
        etapes_recette.append(etape)
    conn.commit()

    close_sql(cur)

    famille = Famille(recette_famille, nom_famille[0], "")
    recette = Recette(recette_id, recette_nom, recette_image, None, recette_cuisson,
                      recette_nb_pers, recette_difficulte, liste_ingredients,
                      etapes_recette, famille)

    return dict(recette=recette)


@route('/chercheRecettes', method='POST')
@view("template/chercheRecettes.tpl")
def rechercher():
    # Récupérer les données du formulaire
    recette_recherchee = request.forms.get('recette')

    if recette_recherchee != "":
        mots_cles = recette_recherchee.split(" ")
        condition = "LIKE '%" + mots_cles[0] + "%'"
        for i in range(1, len(mots_cles)):
            condition += " AND nom LIKE '%" + mots_cles[i] + "%'"
    else:
        condition = "LIKE '%%'"

    conn, cur = open_sql()

    # Requête SQL pour récupérer les recettes d'une famille
    cur.execute("SELECT * FROM recettes WHERE nom " + condition)
    listeRecettes = []
    for row in cur:
        recette_id = row[0]
        recette_nom = row[1]
        recette_image = row[2]
        recette_famille = row[6]
        recette = Recette(recette_id, recette_nom, recette_image,
                          None, None, None, None, None, None, recette_famille)
        listeRecettes.append(recette)

    close_sql(cur)

    return dict(listeRecettes=listeRecettes, recherche=recette_recherchee)


@route('/contact')
@view("static/html/contact.html")
def contact():
    return {}


@route('/mentions')
@view("static/html/mentions.html")
def mentions():
    return {}


@error(404)
@view("static/html/404.html")
def on_error404(error):
    return {}


# Route pour les images
@route('/image/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static/image/')


run(host='0.0.0.0', port=80)
# run(host='localhost', port=8080, debug=True)
