<?php

/*
Classe base abastrata para todas as entidades do sistema
*/
class Entidade
{
    protected ?int $id;
    protected ?string $dataCriacao;
    protected ?string $dataAtualizacao;
    protected ?int $usuarioAtualizacao;
    protected bool $ativo;

    public function __construct(?int $id, bool $ativo = true, ?string $dataCriacao = null, ?string $dataAtualizacao = null, ?int $usuarioAtualizacao = null)
    {
        $this->id = $id;
        $this->dataCriacao = $dataCriacao;
        $this->dataAtualizacao = $dataAtualizacao;
        $this->usuarioAtualizacao = $usuarioAtualizacao;
        $this->ativo = $ativo;
    }

    public function getId(): ?int { return $this->id; }
    public function isAtivo(): bool { return $this->ativo; }
    public function getDataCriacao(): ?string { return $this->dataCriacao; }
    public function getDataAtualizacao(): ?string { return $this->dataAtualizacao; }
    public function getUsuarioAtualizacao(): ?int { return $this->usuarioAtualizacao; }
}