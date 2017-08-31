$txt = '<ul>';
foreach (values %hash)
{
    
    $txt .= '<li>' . $_ . '</li>';
}
$txt .= '</ul>';

$text2 =<<HTML;
$txt
1 2 3
HTML
1;
