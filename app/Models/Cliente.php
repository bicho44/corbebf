<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Cliente extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function datosCliente(){
        return $this->hasMany(DatosCliente::class);
    }

    public function sucursales()
    {
        return $this->hasMany(Sucursales::class);
    }

    public function user(){
        return $this->belongsTo(User::class);
    }

}
