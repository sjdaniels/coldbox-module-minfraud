component extends="testbox.system.BaseSpec"{
/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
	}

	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){

		// MinFraud model
		describe( "Minfraud Model", function(){

			beforeEach(function(){
				minfraud = new root.models.API();
			});

			it("has a service URL", function(){
				expect( minfraud.getServiceURL() ).notToBeNull();		
			});

			it("builds correct Device object", function(){
				expect( minfraud.setDevice("192.168.0.1", "User Agent", "en_US").getRequest().device )
					.toHaveKey( "ip_address", "no ip address" )
					.toHaveKey( "user_agent", "no user agent" )
					.toHaveKey( "accept_language", "no language" )
			});

			it("builds correct Account object", function(){
				expect( minfraud.setAccount("Username", "MD5").getRequest().account )
					.toHaveKey( "user_id", "no user_id" )
					.toHaveKey( "username_md5", "no user name hash" )
			});

			it("builds correct Email object", function(){
				expect( minfraud.setEmail("sean@test.com", "test.com").getRequest().email )
					.toHaveKey( "address", "no address" )
					.toHaveKey( "domain", "no domain" )
			});

			it("builds correct Billing object", function(){
				expect( minfraud.setBilling("First", "Last", "Company", "Street", "Street2", "City", "Region", "Country", "Postal", "Phone Number", "Phone Country Code").getRequest().billing )
					.toHaveKey( "first_name", "no first name" )
					.toHaveKey( "last_name", "no last name" )
					.toHaveKey( "address", "no address" )
					.toHaveKey( "address_2", "no address 2" )
					.toHaveKey( "city", "no city" )
					.toHaveKey( "region", "no region" )
					.toHaveKey( "country", "no country" )
					.toHaveKey( "postal", "no postal" )
					.toHaveKey( "phone_number", "no phone" )
					.toHaveKey( "phone_country_code", "no phone country code" )
			});

			it("builds correct Shipping object", function(){
				expect( minfraud.setShipping("First", "Last", "Company", "Street", "Street2", "City", "Region", "Country", "Postal", "Phone Number", "Phone Country Code", "Overnight").getRequest().shipping )
					.toHaveKey( "first_name", "no first name" )
					.toHaveKey( "last_name", "no last name" )
					.toHaveKey( "address", "no address" )
					.toHaveKey( "address_2", "no address 2" )
					.toHaveKey( "city", "no city" )
					.toHaveKey( "region", "no region" )
					.toHaveKey( "country", "no country" )
					.toHaveKey( "postal", "no postal" )
					.toHaveKey( "phone_number", "no phone" )
					.toHaveKey( "phone_country_code", "no phone country code" )
					.toHaveKey( "delivery_speed", "no delivery speed" )
			});

			it("builds correct Payment object", function(){
				expect( minfraud.setPayment("Processor", true, "declined_soft").getRequest().payment )
					.toHaveKey( "processor", "no processor" )
					.toHaveKey( "was_authorized", "no authorized flag" )
					.toHaveKey( "decline_code", "no decline code" );
			});

			it("builds correct Credit Card object", function(){
				expect( minfraud.setCreditCard("411111", "1111", "Token", "Bank", "1", "555-1212", "M", "M").getRequest().credit_card )
					.toHaveKey( "issuer_id_number", "no BIN" )
					.toHaveKey( "last_4_digits", "no last 4" )
					.toHaveKey( "token", "no token" )
					.toHaveKey( "bank_name", "no bank name" )
					.toHaveKey( "bank_phone_country_code", "no bank phone country code" )
					.toHaveKey( "bank_phone_number", "no bank phone" )
					.toHaveKey( "avs_result", "no AVS" )
					.toHaveKey( "cvv_result", "no CVV" )
					;
			});

			it("builds correct Order object", function(){
				expect( minfraud.setOrder(200, "USD", "discount_code", "Affiliate", "Sub Affiliate", "Referrer", false, false).getRequest().order )
					.toHaveKey( "amount", "no amount" )
					.toHaveKey( "currency", "no currency" )
					.toHaveKey( "discount_code", "no discount code" )
					.toHaveKey( "affiliate_id", "no affiliate" )
					.toHaveKey( "subaffiliate_id", "no sub affiliate" )
					.toHaveKey( "referrer_uri", "no referrer" )
					.toHaveKey( "is_gift", "no gift flag" )
					.toHaveKey( "has_gift_message", "no gift message flag" )
					;
			});

			it("builds correct Event object", function(){
				expect( minfraud.setEvent("TransactionID", "ShopID", "time", "Category").getRequest().event )
					.toHaveKey( "transaction_id", "no transaction id" )
					.toHaveKey( "shop_id", "no shop id" )
					.toHaveKey( "time", "no time" )
					.toHaveKey( "type", "no type" )
					;
			});

			it("adds shopping cart items", function(){
				cart = minfraud
						.appendShoppingCartItem("category", "ItemID", 5, 25)
						.appendShoppingCartItem("category", "ItemID", 5, 25)
						.getRequest()
						.shopping_cart;

				expect( cart ).toHaveLength( 2, "Empty Cart" );
				expect( cart[1] )
					.toHaveKey( "category", "no category for item 1" )
					.toHaveKey( "item_id", "no item_id for item 1" )
					.toHaveKey( "quantity", "no quantity for item 1" )
					.toHaveKey( "price", "no price for item 1" )
					;
			});

			it("builds correct API URLs", function(){
				expect( minfraud.getMethodURL("score") )
					.toBe( "https://minfraud.maxmind.com/minfraud/v2.0/score");
				expect( minfraud.getMethodURL("insights") )
					.toBe( "https://minfraud.maxmind.com/minfraud/v2.0/insights");
				expect( minfraud.getMethodURL("factors") )
					.toBe( "https://minfraud.maxmind.com/minfraud/v2.0/factors");
			});

			it("builds API request successfully", function(){
				minfraud
					.setDevice("192.168.0.1")
					.setBilling(first_name="Sean", last_name="Daniels", country="US", postal="03908")

				var therequest = minfraud.getRequest();

				expect( therequest )
					.toHaveKey( "device" )
					.toHaveKey( "billing" );
				expect( therequest.device )
					.toHaveKey( "ip_address" )
					.notToHaveKey( "user_agent" );
				});

		});
	}
}