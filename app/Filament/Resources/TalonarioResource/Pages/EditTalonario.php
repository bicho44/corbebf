<?php

namespace App\Filament\Resources\TalonarioResource\Pages;

use App\Filament\Resources\TalonarioResource;
use Filament\Pages\Actions;
use Filament\Resources\Pages\EditRecord;

class EditTalonario extends EditRecord
{
    protected static string $resource = TalonarioResource::class;

    protected function getActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
