<?php

namespace App\Filament\Resources\RemitoResource\Pages;

use App\Filament\Resources\RemitoResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;

class ListRemitos extends ListRecords
{
    protected static string $resource = RemitoResource::class;

    protected function getActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
