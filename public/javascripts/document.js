$( "#dialog" ).dialog( {
  autoOpen: true,
  modal: true,
  minWidth: 600,
  minHeight: 330
} );

$( "#opener" ).click( function() {
  $( "#dialog" ).dialog( "open" );
});
