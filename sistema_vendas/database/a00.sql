-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS sistema_vendas;
USE sistema_vendas;

-- Tabela Categoria
CREATE TABLE IF NOT EXISTS Categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1
);

-- Tabela FormaPagamento
CREATE TABLE IF NOT EXISTS FormaPagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1
);

-- Tabela Produto
CREATE TABLE IF NOT EXISTS Produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    dategoriaID INT,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome (Nome),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (CategoriaID) REFERENCES Categoria(Id) ON DELETE SET NULL
);

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome (Nome)
);

-- Tabela Pedido
CREATE TABLE IF NOT EXISTS Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    clienteID INT,
    dataPedido DATETIME NOT NULL,
    formaPagamentoId INT,
    Status VARCHAR(50) NOT NULL,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(Id),
    FOREIGN KEY (FormaPagamentoId) REFERENCES FormaPagamento(Id)
);

-- Tabela ItemPedido
CREATE TABLE IF NOT EXISTS ItemPedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedidoId INT NOT NULL,
    irodutoId INT,
    quantidade INT NOT NULL,
    precoUnitario DECIMAL(10,2) NOT NULL, -- Boa prática para guardar o preço no momento da compra
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    FOREIGN KEY (ProdutoId) REFERENCES Produto(Id) ON DELETE SET NULL,
    -- A MUDANÇA PRINCIPAL ESTÁ AQUI: ON DELETE CASCADE
    FOREIGN KEY (PedidoId) REFERENCES Pedido(Id) ON DELETE CASCADE
);

-- Tabela GrupoUsuario
CREATE TABLE IF NOT EXISTS GrupoUsuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1
);

-- Tabela Permissao
CREATE TABLE IF NOT EXISTS Permissao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    ativo TINYINT(1) DEFAULT 1
);

-- Tabela PermissaoGrupo (Tabela de Ligação)
CREATE TABLE IF NOT EXISTS PermissaoGrupo (
    PermissaoID INT,
    GrupoUsuarioID INT,
    PRIMARY KEY (PermissaoID, GrupoUsuarioID),
    FOREIGN KEY (PermissaoID) REFERENCES Permissao(Id) ON DELETE CASCADE,
    FOREIGN KEY (GrupoUsuarioID) REFERENCES GrupoUsuario(Id) ON DELETE CASCADE
);

-- Tabela Usuario
CREATE TABLE IF NOT EXISTS Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    NomeUsuario VARCHAR(50) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    irupoUsuarioID INT,
    ativo TINYINT(1) DEFAULT 1,
    token VARCHAR(255) DEFAULT NULL,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuarioAtualizacao INT,
    FOREIGN KEY (GrupoUsuarioID) REFERENCES GrupoUsuario(Id)
);