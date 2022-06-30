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
        Schema::create('remito_items', function (Blueprint $table) {
            $table->id();

            $table->foreignId('remito_id')->nullable()->constrained()->cascadeOnDelete();
            $table->foreignId('producto_id')->nullable()->constrained()->cascadeOnDelete();
            $table->integer('cant');
            $table->decimal('unit_price', 10, 2);

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
        Schema::dropIfExists('remito_items');
    }
};
