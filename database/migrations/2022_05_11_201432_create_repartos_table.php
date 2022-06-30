<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('repartos', function (Blueprint $table) {
            $table->id();
            $table->date('fecha')->default(now());
            $table->string('concepto')->nullable();
            $table->integer('cantidad')->nullable();

            /* producto */
            $table->foreignId('productos_id')->constrained();

            /* Conxiones*/
            $table->foreignId('sucursales_id')->constrained();

            /* Vendedor */
            $table->foreignId('user_id')->constrained();

            /* Remitos */
            $table->string('remito')->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cajas');
    }
};
