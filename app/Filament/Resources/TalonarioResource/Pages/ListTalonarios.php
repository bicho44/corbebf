<?php

namespace App\Filament\Resources\TalonarioResource\Pages;

use App\Filament\Resources\TalonarioResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;

class ListTalonarios extends ListRecords
{
    protected static string $resource = TalonarioResource::class;

    protected function getActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
