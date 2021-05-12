//
//  HomeViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Sun 9 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController
{
    // MARK:- Outlets
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK:- Properties
    
    var interactor: HomeInteractorDelegate?
    
    // MARK:- ViewController LifeCycel
    
    // MARK:- Methods
    
    // MARK:- Actions
}

// MARK:- UITextFieldDelegate

extension HomeViewController : UITextFieldDelegate
{
    
}

// MARK:- HomeViewDelegate

extension HomeViewController : HomeViewDelegate
{
    func display(search results: HomeDataManager)
    {
        results.delegate = self
        resultTableView.dataSource = results.dataSource
        resultTableView.delegate = results
        resultTableView.reloadData()
    }
}

// MARK:- HomeDataManagerDelegate

extension HomeViewController : HomeDataManagerDelegate
{
    func didSelect(_ item: Recipe, at indexPath: IndexPath)
    {
        // navigate to recipe info page
    }
}

/*
 carrot
 broccoli
 asparagus
 cauliflower
 corn
 cucumber
 green pepper
 lettuce
 mushrooms
 onion
 potato
 pumpkin
 red pepper
 tomato
 beetroot
 brussel sprouts
 peas
 zucchini
 radish
 sweet potato
 artichoke
 leek
 cabbage
 celery
 chili
 garlic
 basil
 coriander
 parsley
 dill
 rosemary
 oregano
 cinnamon
 saffron
 green bean
 bean
 chickpea
 lentil
 apple
 apricot
 avocado
 banana
 blackberry
 blackcurrant
 blueberry
 boysenberry
 cherry
 coconut
 fig
 grape
 grapefruit
 kiwifruit
 lemon
 lime
 lychee
 mandarin
 mango
 melon
 nectarine
 orange
 papaya
 passion fruit
 peach
 pear
 pineapple
 plum
 pomegranate
 quince
 raspberry
 strawberry
 watermelon
 salad
 pizza
 pasta
 popcorn
 lobster
 steak
 bbq
 pudding
 hamburger
 pie
 cake
 sausage
 tacos
 kebab
 poutine
 seafood
 chips
 fries
 masala
 paella
 som tam
 chicken
 toast
 marzipan
 tofu
 ketchup
 hummus
 chili
 maple syrup
 parma ham
 fajitas
 champ
 lasagna
 poke
 chocolate
 croissant
 arepas
 bunny chow
 pierogi
 donuts
 rendang
 sushi
 ice cream
 duck
 curry
 beef
 goat
 lamb
 turkey
 pork
 fish
 crab
 bacon
 ham
 pepperoni
 salami
 ribs
 */
