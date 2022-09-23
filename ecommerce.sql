drop database ecommerce;
create database ecommerce
default character set utf8
default collate utf8_general_ci;

use ecommerce;

create table cliente (
ID_cliente int not null auto_increment primary key,
Nome varchar(20) not null,
Sobrenome varchar(20) not null,
CPF char(11),
Nascimento date,
Endereço varchar(25) not null,
Tel char (10) not null,
Email varchar(15) not null,
Cidade varchar(20) default'São Paulo' not null,
Estado varchar(20) default'São Paulo' not null,
Frete enum('Sim','Não') default 'Sim',
Crédito decimal(10,2),
Bloqueado decimal (10,2),
Motivo varchar(30),
Cancelamento enum('Sim','Não') default 'Sim',
Devolução enum('Sim','Não') default 'Sim',
Condição enum('Liberado', 'Bloqueado', 'Crédito')
)default charset=utf8;

create table Vendedor (
ID_vendedor int not null auto_increment primary key,
NF int not null, 
Razão_social varchar(30) not null,
Nome_Fantasia varchar(30) not null,
CNPJ char(15) not null,
Endereço varchar(30) not null,
Tel char(10) not null, 
Email varchar(15) not null,
Cidade varchar(20) default'São Paulo' not null,
Estado varchar(20) default'São Paulo' not null,
Condição enum('Liberado','Bloqueado') default 'Liberado' not null,
Aberto date,
Encerrado date
) default char set = utf8;

create table estoque(
ID_estoque int not null auto_increment primary key,
ID_Produto int not null,
Localização char(5) not null,
Quantidade int not null,
Categoria enum('Eletrônicos','roupas','Acessórios','colecionáveis') default 'Eletrônicos' not null,
Descrição 	enum('Bebê', 'Criança', 'Adolescente', 'Adulto') default 'Adulto' not null,
Condição enum('Disponivel', 'Indisponivel') default 'Disponivel'not null,
foreign key (ID_produto) references produto(ID_produto)
) default char set = utf8;

create table fornecedor(
ID_Fornecedor int not null auto_increment primary key,
NF int not null, 
Razão_social varchar(30) not null,
Nome_Fantasia varchar(30) not null,
CNPJ char(15) not null,
Endereço varchar(30) not null,
Tel char(10) not null, 
Email varchar(15) not null,
Cidade varchar(20) default'São Paulo' not null,
Estado varchar(20) default'São Paulo' not null,
Descrição 	enum('Bebê', 'Criança', 'Adolescente', 'Adulto') default 'Adulto' not null,
Quantidade int not null,
Condição enum('Liberado','Bloqueado') default 'Liberado' not null,
Aberto date not null ,
Encerrado date
) default char set = utf8;

create table Produto(
ID_Produto int not null auto_increment primary key,
ID_Cliente int,
ID_Fornecedor int,
ID_Vendedor int,
Cód_produto varchar(10) not null,
Categoria enum('Eletrônicos','roupas','Acessórios','colecionáveis') default 'Eletrônicos' not null,
Descrição enum('Bebê', 'Criança', 'Adolescente', 'Adulto') default 'Adulto' not null,
Quantidade int default '0' not null,
Condição enum('disponivel', 'estoque', 'indisponivel') default 'disponivel' not null,
foreign key(ID_Cliente) references cliente (ID_cliente),
foreign key(ID_Fornecedor) references fornecedor(ID_fornecedor),
foreign key(ID_Vendedor) references vendedor (ID_vendedor)
) default charset = utf8;

create table Pedido (
ID_Pedido int not null auto_increment primary key,
ID_Cliente int,
ID_Fornecedor int,
ID_Vendedor int,
ID_Estoque int,
Identificação_interna varchar(10) not null,
Categoria enum('Eletrônicos','roupas','Acessórios','colecionáveis') default 'Eletrônicos' not null,
Descrição enum('Bebê', 'Criança', 'Adolescente', 'Adulto') default 'Adulto' not null,
Quantidade int default '0' not null,
Condição enum('disponivel', 'estoque', 'indisponivel') default 'disponivel' not null,
foreign key(ID_Cliente) references cliente (ID_cliente),
foreign key(ID_Fornecedor) references fornecedor(ID_fornecedor),
foreign key(ID_Vendedor) references vendedor (ID_vendedor),
foreign key(ID_Estoque) references estoque (ID_estoque)
) default charset = utf8;

create table Pagamento(
ID_pagamento int not null auto_increment primary key,
ID_Pedido int not null,
ID_Cliente int,
ID_Vendedor int,
ID_Fornecedor int,
Pagamento enum('Compra','Receber')default 'Receber' not null,
Condição enum('A Pagar','A receber')default 'A receber' not null,
Entrega enum ('Sim','não') default 'sim' not null,
Aprovação enum('Aprovado','Recusado') default'Aprovado'not null,
Valor decimal(10,2) not null,
foreign key (ID_Pedido) references pedido (ID_pedido),
foreign key (ID_cliente) references cliente(ID_cliente),
foreign key (ID_Vendedor) references vendedor(ID_vendedor),
foreign key (ID_Fornecedor) references fornecedor (ID_fornecedor)
) default charset = utf8;

create table matriz(
ID_Matriz int not null auto_increment primary key,
ID_Pedido int not null,
ID_Cliente int,
ID_Vendedor int,
ID_Fornecedor int,
ID_Produto int,
ID_Estoque int,
ID_Pagamento int,
foreign key (ID_Pedido) references pedido (ID_Pedido),
foreign key (ID_cliente) references cliente(ID_cliente),
foreign key (ID_Vendedor) references vendedor(ID_vendedor),
foreign key (ID_Fornecedor) references fornecedor (ID_fornecedor),
foreign key (ID_Produto) references produto (ID_produto),
foreign key (ID_Estoque) references estoque(ID_estoque),
foreign key (ID_Pagamento) references pagamento(ID_pagamento)
)default charset = utf8
