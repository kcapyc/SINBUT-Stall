function add_to_cart(id)
{
	var key = 'product_' + id;

	var x = window.localStorage.getItem(key); // x = hh['bbb']
	x = x * 1 + 1; // x = x + 1
	window.localStorage.setItem(key, x); // hh['bbb'] = x

	alert('Книга добавлена в корзину');

	update_order();
	order_button();
}

function get_cart_number()
{
	var cnt = 0;

	for(var i = 0; i < window.localStorage.length; i++)
	{
		var key = window.localStorage.key(i);
		var value = window.localStorage.getItem(key); // hh[key] = x

		if(key.indexOf('product_') == 0)
		{
			cnt = cnt + value * 1;
		}
	}

	return cnt;
}

function update_order()
{
	var orders = get_cart_order();
	$('#order_input').val(orders);
}

function order_button()
{
	var text = 'Корзина (' + get_cart_number() + ')';
	$('#order_button').val(text);
}

function get_cart_order()
{
	var orders = '';

	for(var i = 0; i < window.localStorage.length; i++)
	{
		var key = window.localStorage.key(i);
		var value = window.localStorage.getItem(key); // hh[key] = x

		if(key.indexOf('product_') == 0)
		{
			orders = orders + key + '=' + value + ',';
		}
	}
	return orders;
}

function cancel_order()
	{
		window.localStorage.clear();
		update_order();
		order_button();
		$('#cart').text('Вы очистили свою корзину.')
	}