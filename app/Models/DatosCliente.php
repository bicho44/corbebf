<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class DatosCliente extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $table = 'datoscliente';

    public function cliente()
    {
        return $this->belongsTo(Cliente::class);
    }


}
