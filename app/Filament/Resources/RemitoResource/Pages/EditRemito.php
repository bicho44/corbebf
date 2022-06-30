<?php

namespace App\Filament\Resources\RemitoResource\Pages;

use App\Filament\Resources\RemitoResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\EditRecord;

class EditRemito extends EditRecord
{
    protected static string $resource = RemitoResource::class;

    protected function getActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
