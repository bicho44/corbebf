<?php

namespace App\Filament\Resources;

use App\Filament\Resources\SucursalesResource\Pages;
use App\Filament\Resources\SucursalesResource\RelationManagers;
use App\Models\Cliente;
use App\Models\Sucursales;
use App\Models\User;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\Resource;
use Filament\Resources\Table;
use Filament\Tables;

class SucursalesResource extends Resource
{
    protected static ?string $model = Sucursales::class;

    protected static ?string $navigationIcon = 'heroicon-o-table';

    protected static ?string $navigationLabel = 'Direcciones Clientes';

    protected static ?string $label = 'Direcciones Clientes';

    protected static ?string $navigationGroup = 'Clientes';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('cliente_id')
                    ->label('Cliente')
                    ->options(Cliente::all()->pluck('name', 'id'))
                    ->searchable()
                    ->required(),
                Forms\Components\TextInput::make('direccion')
                    ->label('Dirección')
                    ->required(),
                Forms\Components\MultiSelect::make('dia_reparto')
                    ->label('Dia de Reparto')
                    ->options(['lunes'=>'Lunes', 'martes'=>'Martes',
                        'miercoles'=>'Miercoles', 'jueves'=>'Jueves',
                        'viernes'=>'Viernes', 'sabado'=>'Sabado',
                        'domingo'=>'Domingo'])
                    ->required(),
                Forms\Components\TextInput::make('orden_entrega')
                    ->label('Orden de Entrega')
                    ->numeric(),
                Forms\Components\Select::make('user_id')
                    ->label('Repartidor')
                    ->options(User::all()->pluck('name', 'id'))
                    ->searchable()
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('cliente.name')
                    ->label('Cliente')
                    ->sortable(),
                Tables\Columns\TextColumn::make('direccion')
                    ->label('Direcciones')
                    ->sortable(),
                Tables\Columns\TextColumn::make('user.name')
                    ->label('Repartidor'),
                Tables\Columns\TagsColumn::make('dia_reparto')
                    ->label('Dia De Reparto'),
                Tables\Columns\TextColumn::make('orden_entrega')
                    ->label('Orden de Entrega'),
            ])
            ->filters([
                //
            ]);
    }

    public static function getRelations(): array
    {
        return [
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListSucursales::route('/'),
            'create' => Pages\CreateSucursales::route('/create'),
            'edit' => Pages\EditSucursales::route('/{record}/edit'),
        ];
    }
}
