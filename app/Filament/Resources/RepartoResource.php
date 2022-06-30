<?php

namespace App\Filament\Resources;

use App\Filament\Resources\RepartoResource\Pages;
use App\Filament\Resources\RepartoResource\RelationManagers;
use App\Models\Cliente;
use App\Models\Producto;
use App\Models\Reparto;
use App\Models\Sucursales;
use App\Models\User;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\Resource;
use Filament\Resources\Table;
use Filament\Tables;
use function str_pad;
use function today;
use const STR_PAD_LEFT;

class RepartoResource extends Resource
{
    protected static ?string $model = Reparto::class;

    protected static ?string $navigationIcon = 'heroicon-o-shopping-cart';

    protected static ?string $navigationGroup = 'Reparto';

    public static function form(Form $form): Form
    {

        return $form
            ->columns(3)
            ->schema([
                Forms\Components\TextInput::make('remito')
                    ->rules('required')
                    ->numeric()
                    ->label('Remito Nro')
                    ->default(function () {
                        return Reparto::max('remito') + 1;
                    }),

                Forms\Components\Select::make('cliente_id')
                    ->label('Cliente')
                    ->options(Cliente::all()->pluck('name', 'id'))
                    ->searchable()
                    ->reactive()
                    ->afterStateUpdated(fn (callable $set) => $set('sucursales_id', null)),

                Forms\Components\Select::make('sucursales_id')
                    ->label('Sucursal')
                    ->options( function (callable $get){

                        $clientes = Cliente::find($get('cliente_id'));

                        if (! $clientes) {
                            return Sucursales::all()->pluck('direccion', 'id');
                        }
                        return $clientes->sucursales->pluck('direccion', 'id');
                    }),
                Forms\Components\DatePicker::make('fecha')
                    ->label('Fecha')
                    ->default(today('M d, Y'))
                    ->required(),
                Forms\Components\TextInput::make('concepto')
                    ->label('Concepto'),
                Forms\Components\TextInput::make('cantidad')
                    ->label('Cantidad'),
                Forms\Components\Select::make('productos_id')
                    ->label('Producto')
                    ->options(Producto::all()->pluck('nombre', 'id'))
                    ->searchable(),

                Forms\Components\Select::make('user_id')
                    ->label('Repartidor')
                    ->options(User::all()->pluck('name', 'id'))
                    ->default(auth()->user()->id)
                    ->searchable()
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('talonarios.talonario'.'-'.str_pad('remito', 2, '0', STR_PAD_LEFT))
                    ->label('Talonario')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('remito')
                    ->label('Remito')
                    ->sortable()
                    ->searchable()
                ->alignRight(),

                Tables\Columns\TextColumn::make('fecha')
                    ->label('Fecha')
                    ->date('Y-m-d')
                    ->sortable(),

                Tables\Columns\TextColumn::make('sucursales.cliente.name')
                    ->label('Cliente'),
                //Tables\Columns\TextColumn::make('sucursales.direccion')
                    //->label('Direccion'),

                Tables\Columns\TextColumn::make('cantidad')
                    ->label('Cant')
                    ->alignCenter(),
                Tables\Columns\TextColumn::make('productonombre.nombre')
                    ->label('Producto'),

                Tables\Columns\TextColumn::make('concepto')
                    ->label('Descripción'),

            ])
            ->filters([
                //
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListRepartos::route('/'),
            'create' => Pages\CreateReparto::route('/create'),
            'edit' => Pages\EditReparto::route('/{record}/edit'),
        ];
    }
}
