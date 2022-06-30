<?php

namespace App\Filament\Resources\ClienteResource\RelationManagers;

use App\Models\User;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\RelationManagers\HasManyRelationManager;
use Filament\Resources\Table;
use Filament\Tables;

class SucursalesRelationManager extends HasManyRelationManager
{
    protected static string $relationship = 'sucursales';

    protected static ?string $recordTitleAttribute = 'direccion';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
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
                Tables\Columns\TextColumn::make('direccion')->label('Dirección'),
                Tables\Columns\TagsColumn::make('dia_reparto')
                    ->label('Dia De Reparto'),
                Tables\Columns\TextColumn::make('orden_entrega')
                    ->label('Orden de Entrega'),
                Tables\Columns\TextColumn::make('user.name')
                    ->label('Repartidor'),
                ])
            ->filters([
                //
            ]);
    }
}
