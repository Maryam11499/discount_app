<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get("/test", function() {
    return response()->json([
        'message' => 'Hello, World',
        'stores' => [
            ['store'=>'Ossob', 'item'=>'Latte', 'price'=>4.00, 'percent_off'=>25],
            ['store'=>'Aaran', 'item'=>'Cappuccino', 'price'=>3.50, 'percent_off'=>10],
            ['store'=>'Jubba HyperMarket', 'item'=>'Americano', 'price'=>3.00, 'percent_off'=>5]
        ]
    ]);
});
