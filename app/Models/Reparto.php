<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Reparto extends Model
{
    use HasFactory;

    protected $guarded = [
        'cliente_id',
    ];

    protected $casts = [
        'fecha' => 'date:Y-m-d',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function cliente(): BelongsTo
    {
        return $this->belongsTo(Cliente::class);
    }

    public function productonombre(): BelongsTo
    {
        return $this->belongsTo(
            Producto::class,
            'productos_id',
        );
    }

    public function sucursales(): BelongsTo
    {
        return $this->belongsTo(Sucursales::class);
    }

    public function talonarios()
    {
        return $this->hasOne(
            Talonarios::class,
            'id',
        );
    }
}
