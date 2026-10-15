const _componentNames = {
  'Action Menu': 'Menu de ações',
  'Alert Dialog': 'Caixa de diálogo',
  'Big Button': 'Botão grande',
  'Bottom Bar': 'Barra inferior',
  'Button': 'Botão',
  'Calendar': 'Calendário',
  'Checkbox': 'Caixa de seleção',
  'Dropdown': 'Lista suspensa',
  'Icon Button': 'Botão com ícone',
  'Linear Progress': 'Barra de progresso',
  'Overview Card': 'Cartão de resumo',
  'Radio': 'Botão de opção',
  'Side Menu': 'Menu lateral',
  'Slider': 'Controle deslizante',
  'Switch': 'Interruptor',
  'Tab Bar': 'Barra de abas',
  'Task Card': 'Cartão de tarefa',
  'Text Button': 'Botão de texto',
  'TextField': 'Campo de texto',
  'Time Picker': 'Seletor de horário',
};

const _configLabels = {
  'Action Bar Color': 'Cor da barra de ações',
  'Action Bar Height': 'Altura da barra de ações',
  'Alert Dialog': 'Caixa de diálogo',
  'Animated': 'Animado',
  'Animation (ms)': 'Duração da animação (ms)',
  'Background Color': 'Cor de fundo',
  'Border Color': 'Cor da borda',
  'Border Radius': 'Raio da borda',
  'BorderRadius': 'Raio da borda',
  'Bottom Bar': 'Barra inferior',
  'Button': 'Botão',
  'Button Color': 'Cor do botão',
  'Cancel Button': 'Botão de cancelamento',
  'Cancel Button Background Color': 'Cor de fundo do botão de cancelamento',
  'Cancel Button Text Color': 'Cor do texto do botão de cancelamento',
  'Checkbox': 'Caixa de seleção',
  'Color': 'Cor',
  'Confirm Button': 'Botão de confirmação',
  'Confirm Button Background Color': 'Cor de fundo do botão de confirmação',
  'Confirm Button Text Color': 'Cor do texto do botão de confirmação',
  'Content Color': 'Cor do conteúdo',
  'Dialog Background Color': 'Cor de fundo da caixa de diálogo',
  'Dropdown': 'Lista suspensa',
  'Feedback': 'Retorno visual',
  'Feedback Text': 'Texto do retorno visual',
  'Font Color': 'Cor da fonte',
  'Font Size': 'Tamanho da fonte',
  'Haptic': 'Retorno tátil',
  'Height': 'Altura',
  'Icon': 'Ícone',
  'Icon Color': 'Cor do ícone',
  'Icon Size': 'Tamanho do ícone',
  'Inactive Color': 'Cor inativa',
  'Interaction': 'Interação',
  'Item Padding Horizontal': 'Espaçamento horizontal do item',
  'Item Padding Vertical': 'Espaçamento vertical do item',
  'Label Color': 'Cor do rótulo',
  'Layout': 'Disposição',
  'Linear Progress': 'Barra de progresso',
  'List Color': 'Cor da lista',
  'Margin': 'Margem',
  'Opacity': 'Opacidade',
  'Overview Card': 'Cartão de resumo',
  'Padding': 'Espaçamento interno',
  'Press Delay (ms)': 'Atraso ao pressionar (ms)',
  'Radio': 'Botão de opção',
  'Scale': 'Escala',
  'Show Label (%)': 'Exibição do rótulo (%)',
  'Side Menu': 'Menu lateral',
  'Size': 'Tamanho',
  'Slider': 'Controle deslizante',
  'Spacing': 'Espaçamento',
  'Surface Tint Color': 'Cor de tonalização da superfície',
  'Switch': 'Interruptor',
  'Tab Bar': 'Barra de abas',
  'Task Card': 'Cartão de tarefa',
  'Textfield': 'Campo de texto',
  'Time Picker': 'Seletor de horário',
  'Title Color': 'Cor do título',
  'Touch Padding': 'Área de toque',
  'Width': 'Largura',
};

String assistiveComponentNamePt(String name) => _componentNames[name] ?? name;

String assistiveConfigLabelPt(String label) => _configLabels[label] ?? label;

String assistiveFeedbackPt(String message) {
  const translations = {
    'Action menu': 'Menu de ações',
    'Action performed': 'Ação realizada',
    'Button pressed': 'Botão pressionado',
    'Cancelled': 'Cancelado',
    'Card Pressed': 'Cartão pressionado',
    'Checked': 'Marcado',
    'Confirmed': 'Confirmado',
    'Disabled': 'Desativado',
    'Dropdown Selected': 'Opção selecionada',
    'Enabled': 'Ativado',
    'Icon button pressed': 'Botão com ícone pressionado',
    'Tab changed': 'Aba alterada',
    'Textfield Activated': 'Campo de texto ativado',
    'Unchecked': 'Desmarcado',
  };

  final translated = translations[message];
  if (translated != null) return translated;
  if (message.startsWith('Tab: ')) return 'Aba: ${message.substring(5)}';
  if (message.startsWith('Value: ')) return 'Valor: ${message.substring(7)}';
  if (message.startsWith('Selected: ')) return 'Selecionado: ${message.substring(10)}';
  if (message.startsWith('Time selected: ')) {
    return 'Horário selecionado: ${message.substring(15)}';
  }
  return message;
}
