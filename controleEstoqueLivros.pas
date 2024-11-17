{$codepage utf8} 
program ControleEstoqueLivros;

uses crt;

type
    Livro = record
        codigo: integer;
        titulo: string[50];
        autor: string[50];
        preco: real;
        quantidade: integer;
    end;

    ListaLivros = array[1..100] of Livro;

var
    livros:ListaLivros;
    totalLivros:integer;

function geraCodigo():integer;
begin
    Randomize;
    geraCodigo:=Random(10000)+1;
end;

procedure mostraLivro(livroExibir:Livro);
begin
    writeln('Código: ', livroExibir.codigo);
    writeln('Título: ', livroExibir.titulo);
    writeln('Autor: ', livroExibir.autor);
    writeln('Preço: ', livroExibir.preco:0:2);
    writeln('Quantidade: ', livroExibir.quantidade);
end;

function adicionarLivro():Livro;
var
    novoLivro:Livro;
begin
    novoLivro.codigo:=geraCodigo();
    write('Título: ');
    readln(novoLivro.titulo);
    write('Autor: ');
    readln(novoLivro.autor);
    write('Preço: ');
    readln(novoLivro.preco);
    write('Quantidade: ');
    readln(novoLivro.quantidade);
    adicionarLivro:=novoLivro;
end;

procedure listarLivros(lista:ListaLivros; quant:integer);
var
    i: integer;
begin
    for i:=1 to quant do
    begin
        writeln('Livro ', i, ':');
        mostraLivro(lista[i]);
    end;
end;

function buscarLivro(lista:ListaLivros; codigo:integer): integer;
var
    i:integer;
begin
    for i:=1 to totalLivros do
    begin
        if lista[i].codigo=codigo then
        begin
            buscarLivro:=i;
            exit;
        end;
    end;
    buscarLivro:= -1;
end;

function venderLivro(var lista:ListaLivros; posicao, quant: integer): boolean;
begin
    if (posicao>0) and (posicao<=totalLivros) and (lista[posicao].quantidade>=quant) then
    begin
        lista[posicao].quantidade:=lista[posicao].quantidade-quant;
        writeln('Venda realizada com sucesso. Total: R$', lista[posicao].preco*quant:0:2);
        venderLivro := true;
    end
    else
    begin
        writeln('----------------------------------------------');
        writeln('Estoque insuficiente ou livro não encontrado.');
        writeln('----------------------------------------------');
        venderLivro := false;
    end;
end;

procedure menu();
var
    opcao, codigo, posicao, quantidade: integer;
    novoLivro:Livro;
begin
    repeat
        writeln('----------------------------------------------');
        writeln('1 - Adicionar um novo livro ao estoque');
        writeln('2 - Listar todos os livros');
        writeln('3 - Buscar um livro pelo código');
        writeln('5 - Vender livro');
        writeln('6 - Sair');
        writeln('----------------------------------------------');
        write('Escolha uma opção: ');
        readln(opcao);
        writeln('----------------------------------------------');
        case opcao of
            1: begin
                     novoLivro:=adicionarLivro();
                     inc(totalLivros);
                     livros[totalLivros]:=novoLivro;
                 end;
            2: listarLivros(livros, totalLivros);
            3: begin
                     write('Digite o código do livro: ');
                     readln(codigo);
                     posicao:=buscarLivro(livros, codigo);
                     if posicao <> -1 then
                         mostraLivro(livros[posicao])
                     else
                         writeln('Livro não encontrado.');
                 end;
            5: begin
                     write('Digite o código do livro: ');
                     readln(codigo);
                     posicao:=buscarLivro(livros, codigo);
                     if posicao <> -1 then
                     begin
                         write('Digite a quantidade a ser vendida: ');
                         readln(quantidade);
                         venderLivro(livros, posicao, quantidade);
                     end
                     else
                         writeln('Livro não encontrado.');
                 end;
        end;
    until opcao=6;
    writeln('Obrigado por utilizar o sistema de controle de estoque de livros, volte sempre!');
end;

begin
    clrscr;
    totalLivros:=0;
    menu();
end.