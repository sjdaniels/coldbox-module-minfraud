component {

	function getSettings() provider="coldbox:setting:maxmind" {}

	public function init() {
		variables.serviceURL = "https://minfraud.maxmind.com/minfraud/v2.0/";
		variables.methods = ["score", "insights", "factors"];
		variables.request = {};
		return this;
	}

	public any function reset() {
		variables.request = {};
		return this;
	}

	public struct function getResult(required string method, array keys) {
		var cfhttp;
		var therequest = getRequest();

		if (!therequest.len() || !therequest.keyexists("device"))
			throw(type="com.braunsmedia.MaxMind",detail="Device object is required.");

		http url="#getMethodURL(arguments.method)#" method="post" username="#getSettings().userID#" password="#getSettings().key#" {
			httpparam type="header" name="Content-Type" value="application/vnd.maxmind.com-minfraud-#arguments.method#+json; charset=UTF-8; version=2.0";
			httpparam type="body" value="#serializeJSON(therequest)#";
		}

		try {
			var result = deserializeJSON(cfhttp.filecontent);
		}
		catch (any var e) {
			throw(type="com.braunsmedia.MaxMind",detail="Unable to deserialize response.",extendedinfo=serializeJSON(cfhttp));
		}

		if (structkeyexists(result,"error")) {
			throw(type="com.braunsmedia.MaxMind",detail="Error response from API.",extendedinfo=result.error);
		}

		if (!isnull(arguments.keys)) {
			for (local.key in result) {
				if (!arguments.keys.find(local.key)) {
					structdelete(result,local.key);
				}
			}
		}

		return result;
	}

	public string function getServiceURL() {
		return variables.serviceURL;
	}

	public string function getMethodURL(required string method) {
		return variables.serviceURL & arguments.method;
	}

	public struct function getRequest() {
		return variables.request;
	}

	public API function setDevice(required string ip_address, string user_agent, string accept_language) {
		variables.request["device"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.device[arg] = arguments[arg];
		}
		return this;
	}

	public API function setAccount(string user_id, string username_md5) {
		variables.request["account"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.account[arg] = arguments[arg];
		}
		return this;
	}

	public API function setEmail(string address, string domain) {
		variables.request["email"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.email[arg] = arguments[arg];
		}
		return this;
	}

	public API function setBilling(string first_name, string last_name, string company, string address, string address_2, string city, string region, string country, string postal, string phone_number, string phone_country_code) {
		variables.request["billing"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.billing[arg] = arguments[arg];
		}
		return this;
	}

	public API function setShipping(string first_name, string last_name, string company, string address, string address_2, string city, string region, string country, string postal, string phone_number, string phone_country_code, string delivery_speed) {
		variables.request["shipping"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.shipping[arg] = arguments[arg];
		}
		return this;
	}

	public API function setPayment(string processor, boolean was_authorized, string decline_code) {
		variables.request["payment"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.payment[arg] = arguments[arg];
		}
		return this;
	}

	public API function setCreditCard(string issuer_id_number, string last_4_digits, string token, string bank_name, string bank_phone_country_code, string bank_phone_number, string avs_result, string cvv_result) {
		variables.request["credit_card"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.credit_card[arg] = arguments[arg];
		}
		return this;
	}

	public API function setOrder(numeric amount, string currency, string discount_code, string affiliate_id, string subaffiliate_id, string referrer_uri, boolean is_gift, boolean has_gift_message) {
		variables.request["order"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.order[arg] = arguments[arg];
		}
		return this;
	}

	public API function setEvent(string transaction_id, string shop_id, string time, string type) {
		variables.request["event"] = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				variables.request.event[arg] = arguments[arg];
		}
		return this;
	}

	public API function appendShoppingCartItem(string category, string item_id, numeric quantity, numeric price) {
		variables.request["shopping_cart"] = variables.request.shopping_cart ?: [];
		var item = {}
		for (var arg in arguments) {
			if (!isnull(arguments[arg]))
				item[arg] = arguments[arg];
		}

		variables.request.shopping_cart.append(item);
		return this;
	}
}