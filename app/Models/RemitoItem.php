<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RemitoItem extends Model
{
    use HasFactory;

    protected $guarded = [];

    /**
     * @var string
     */
    protected $table = 'remito_items';

    /**
     * @return BelongsTo
     */
    public function remito(): BelongsTo
    {
        return $this->belongsTo(Remito::class);
    }
}
