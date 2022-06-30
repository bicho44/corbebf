<?php

namespace App\Filament\Widgets;

use App\Models\Cliente;
use App\Models\Producto;
use App\Models\Reparto;
use App\Models\Sucursales;
use App\Models\User;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Card;
use function array_push;
use function implode;

class StatsGenerales extends BaseWidget
{

    public function repartoDiaro()
    {
        return $cantRepartidas = Reparto::where([
            ['fecha', '=', date('Y-m-d')],
            ['cantidad', '>', '0'],
        ])->sum('cantidad');
    }

    public function repartoMensual()
    {
        return $cantRepartidas = Reparto::where([
            ['fecha', '>=', date('Y-m-01')],
            ['fecha', '<=', date('Y-m-t')],
            ['cantidad', '>', '0'],
        ])->sum('cantidad');
    }

    public function repartoMensualxVendedor()
    {
        $repartos = Reparto::where([
            ['fecha', '>=', date('Y-m-01')],
            ['fecha', '<=', date('Y-m-t')],
            ['cantidad', '>', '0'],
        ])->get();
        $vendedores = User::All();

        $repartosxVendedor = [];

        foreach ($vendedores as $vendedor) {
            $repartosxVendedor[$vendedor->id] = 0;
        }

        foreach ($repartos as $reparto) {
            $repartosxVendedor[$reparto->user_id] += $reparto->cantidad;
        }
        foreach ($repartosxVendedor as $key => $value) {
            $vendedor = User::find($key);

            $repartosxVendedor[$key] = $vendedor->name.': '.$value;
        }

        return $repartosxVendedor;

    }

    protected function getCards(): array
    {
        return [
            Card::make('Hoy', $this->repartoDiaro() . ' unidades'),
            Card::make('Mes', $this->repartoMensual() . ' unidades'),
            Card::make('Mes x Vendedor', implode(", ",$this->repartoMensualxVendedor()) . ' unidades'),

            Card::make('Clientes', Cliente::all()->count()),
            Card::make('Direcciones', Sucursales::all()->count()),
            Card::make('Vendedores', User::all()->count()),
        ];
    }
}
