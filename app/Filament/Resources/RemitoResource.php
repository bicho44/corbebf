<?php

namespace App\Filament\Resources;

use App\Filament\Resources\RemitoResource\Pages;
use App\Filament\Resources\RemitoResource\RelationManagers;
use App\Models\Remito;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\Resource;
use Filament\Resources\Table;
use Filament\Tables;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use App\Models\Cliente;
use App\Models\Sucursales;
use Filament\Forms\Components\Textarea;
use App\Models\Talonario;
use App\Models\Producto;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Card;
use Filament\Forms\Components\Repeater;
use App\Models\User;
use Filament\Forms\Components\Hidden;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\DatePicker;

class RemitoResource extends Resource
{
    protected static ?string $model = Remito::class;

    protected static ?string $navigationIcon = 'heroicon-o-collection';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([

                Hidden::make('user_id')->default(auth()->id()),

                DatePicker::make('fecha_remito')
                    ->format('YYYY-MM-DD')
                    ->label('Fecha')
                    ->default(now()->format('Y-m-d'))
                    ->columnSpan(1),

                Card::make()
                    ->schema([                
                        Select::make('nro_talonario')
                            ->options(Talonario::all()->pluck('talonario', 'id'))
                            ->required()
                            ->default('user.talonario')
                            ->label('Nro. Talonario')
                            ->reactive()
                            ->afterStateUpdated(

                                fn ($state, callable $set) => $set('nro_remito', Remito::where('nro_talonario',$state)?->max('nro_remito') + 1 ?? 0)

                            ),
                        
                        TextInput::make('nro_remito')
                            ->required()
                            ->numeric()
                            ->label('Remito Nro'),

                        Select::make('cliente_id')
                            ->label('Cliente')
                            ->required()
                            ->relationship('cliente', 'name')
                            ->searchable()
                            ->reactive()
                            ->afterStateUpdated(fn (callable $set) => $set('sucursales_id', null)),
                            
                        Select::make('sucursales_id')
                            ->label('Sucursal')
                            ->required()
                            ->options( function (callable $get){

                                $clientes = Cliente::find($get('cliente_id'));

                                if (! $clientes) {
                                    return Sucursales::all()->pluck('direccion', 'id');
                                }
                                return $clientes->sucursales->pluck('direccion', 'id');
                            }),
                        ])
                        ->columns([
                            'sm' => 2,
                        ])
                        ->columnSpan([
                            'sm' => 2,
                        ]),
                
                    Card::make()
                    ->schema([
                        Repeater::make('Remito Items')
                            ->relationship('items')
                            ->schema([
                                Select::make('producto_id')
                                    ->label('Producto')
                                    ->options(Producto::query()->pluck('nombre', 'id'))
                                    ->required()
                                    ->reactive()
                                    ->afterStateUpdated(fn ($state, callable $set) => $set('unit_price', Producto::find($state)?->precio ?? 0))
                                    ->columnSpan([
                                        'md' => 5,
                                    ]),
                                TextInput::make('cant')
                                    ->numeric()
                                    ->mask(
                                        fn (Forms\Components\TextInput\Mask $mask) => $mask
                                            ->numeric()
                                            ->integer()
                                    )
                                    ->default(1)
                                    ->columnSpan([
                                        'md' => 2,
                                    ])
                                    ->required(),
                                TextInput::make('unit_price')
                                    ->label('Precio')
                                    ->numeric()
                                    ->required()
                                    ->columnSpan([
                                        'md' => 3,
                                    ]),
                            ])
                            ->defaultItems(1)
                            ->disableLabel()
                            ->columns([
                                'md' => 10,
                            ])
                            ->required(),
                    ]),

                Textarea::make('notes')->label('Observaciones')
                    ->maxLength(65535),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('nro_talonario')
                    ->formatStateUsing(fn (string $state) => str_pad($state, 3,'0',STR_PAD_LEFT)),
                TextColumn::make('nro_remito')
                    ->formatStateUsing(fn (string $state) => str_pad($state, 5,'0',STR_PAD_LEFT))
                    ->searchable()
                    ->sortable(),
                TextColumn::make('cliente.name')->label('Cliente')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('sucursal.direccion')->label('Sucursal'),
                
                TextColumn::make('notes'),
                
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
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
            'index' => Pages\ListRemitos::route('/'),
            'create' => Pages\CreateRemito::route('/create'),
            'edit' => Pages\EditRemito::route('/{record}/edit'),
        ];
    }    
}
