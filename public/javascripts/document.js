$( "#dialog" ).dialog( {
  autoOpen: false,
  modal: true,
  minWidth: 600,
  minHeight: 330
} );

$( "#opener" ).click( function() {
  $( "#dialog" ).dialog( "open" );
});
