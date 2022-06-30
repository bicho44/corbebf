<?php

namespace App\Filament\Resources;

use App\Filament\Resources\TalonarioResource\Pages;
use App\Filament\Resources\TalonarioResource\RelationManagers;
use App\Models\Talonario;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\Resource;
use Filament\Resources\Table;
use Filament\Tables;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use App\Models\User;
use Filament\Tables\Columns\TextColumn;

class TalonarioResource extends Resource
{
    protected static ?string $model = Talonario::class;

    protected static ?string $navigationIcon = 'heroicon-o-collection';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('talonario')->label('Nro. Talonario'),
                Select::make('user_id')->options(User::all()->pluck('name', 'id'))
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('talonario')->label('Nro. Talonario'),
                TextColumn::make('user.name')->label('Usuario'),
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
            'index' => Pages\ListTalonarios::route('/'),
            'create' => Pages\CreateTalonario::route('/create'),
            'edit' => Pages\EditTalonario::route('/{record}/edit'),
        ];
    }    
}
