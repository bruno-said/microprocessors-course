#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

/**
 * @description: 
 *  Função para verificar de uma string é substring de outra
 * @param:
 *  substring: A substring a ser avalidada
 *  string: A string a ser avaliada
 */
uint8_t isSubstring ( char * substring, char * string )
{
  uint8_t lenSub = strlen( substring ), lenStr = strlen( string );

  if ( lenSub <= lenStr )
  {
    uint8_t i;
    for ( i = 0; i < lenSub; i++ )
      if ( substring[ i ] != string[ i ] )
        return 0;

    return 1;
  }

  return 0;
}

/**
 * @description: 
 *  Função para converter uma string em um byte
 * @parm:
 *  buffer: String para conversão
 *  byte: byte para receber o conversão
 */
void bufferToByte ( uint8_t * buffer, uint8_t * byte )
{
  uint8_t i, len = strlen( buffer );

  *byte = 0;

  for ( i = 0; i < len; i++ )
    if ( buffer[ i ] == '1' )
      ( *byte ) |= ( 1 << ( ( len - 1 ) - i ) );
}

int main ( int argc, char ** argv )
{
  FILE * input = fopen( "input.asm", "r" ); // Ponteiro para manipulação do arquivo de entrada
  FILE * output = fopen( "output", "wb" );  // Ponteiro para manipulação do arquivo de saída

  uint8_t index = 0;      // Indíce para controle do buffer
  uint8_t buffer[ 8 ];    // Buffer que recebe as linha do arquivo de entrada
  uint8_t readByte[ 1 ];  // Byte para ler do arquivo de entrada
  uint8_t writeByte[ 1 ]; // Byte para escrever no arquivo de saída

  // Enquanto ouver bytes para serem lidos
  while ( fread( readByte, sizeof( uint8_t ), 1, input ) )
  {
    // Se o byte lido for uma quebra de linha
    if ( readByte[ 0 ] == '\n' )
    {
      index = 0; // Reiniciamos o índice de controle do buffer 

      if ( isSubstring( "ADD", buffer ) ) // Verificamos se o que está armazenado no buffer é a instrução ADD
        writeByte[ 0 ] = 0; // Escrevermos na saída o byte correspondente a instrução ADD (0b00000000)
      else if ( isSubstring( "SUB", buffer ) ) // Verificamos se o que está armazenado no buffer é a instrução SUB
        writeByte[ 0 ] = 1; // Escrevermos na saída o byte correspondente a instrução SUB (0b00000001)
      else // Caso não seja uma instrução deve ser um número
        bufferToByte( buffer, writeByte ); // Converter a string do buffer para um único byte

      fwrite( writeByte, sizeof( uint8_t ), 1, output ); // Escrevendo o byte no arquivo de saída
    }
    else // Caso não seja um caractere de quebra de linha
      buffer[ index++ ] = readByte[ 0 ]; // Armazenamos o caractere no buffer
  }

  // Caso no final do arquivo ainda sobre caracteres não processado no buffer
  if ( index > 0 )
  {
    bufferToByte( buffer, writeByte ); // Convertemos a string para byte
    fwrite( writeByte, sizeof( uint8_t ), 1, output ); // Escrevendo o byte no arquivo de saída
  }
  
  fclose( input );  // Liberando ponteiro do arquivo de entrada
  fclose( output ); // Liberando ponteiro do arquivo de saída

  return 0;
}