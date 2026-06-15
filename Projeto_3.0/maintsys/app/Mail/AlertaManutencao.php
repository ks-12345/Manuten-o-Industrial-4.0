<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;

use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class AlertaManutencao extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(
        public readonly string $codigoOrdemServico,
        public readonly string $maquina,
        public readonly string $setor,
        public readonly string $tecnico,
        public readonly string $urgencia,
        public readonly string $descricaoProblema,
    ) {
    }

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: '🚨 Manutenção Industrial 4.0 - Atualização de Chamado',
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.alerta',
            with: [
                'codigoOrdemServico' => $this->codigoOrdemServico,
                'maquina' => $this->maquina,
                'setor' => $this->setor,
                'tecnico' => $this->tecnico,
                'urgencia' => $this->urgencia,
                'descricaoProblema' => $this->descricaoProblema,
            ],
        );
    }
}

