const SV=0;
const BB=1;
const SG=2;
class Bill{
  constructor(name, shop,items){
   this.name=name;this.items=items;this.shop=shop;
    }
  calc(){
    this.total=0;
    for (let i=0; i<this.items.length;i++){
      this.total+=this.items[i].cost;
    }
    return this.total;
  }
  printItems(){
    for (let i=0; i<this.items.length;i++){
      print(this.items[i].name)

    }
  }
}
class Item{
  constructor(name,category,quantity,price){
    this.name=name;
    this.cat=category;
    this.qt=quantity
    this.price=price;
    this.cost=price*quantity;
  }
}
function Items(names,categories,quantities,prices){
	let ittems=[];
  for (let i=0; i<names.length; i++){
  	ittems.push(new Item(names[i],categories[i],quantities[i],prices[i]))
    }
  return ittems
}
let bills=[];
bills.push(new Bill("Srivatsan",SV));
bills.push(new Bill("Sudeep",BB));
bills.push(new Bill("Akshya",SV));
bills.push(new Bill("Advaith",SV));
bills.push(new Bill("Akshaya",BB));
bills.push(new Bill("Srivatsan",SG));
bills.push(new Bill("Akhil",SV));
bills.push(new Bill("Advaith",BB));
bills.push(new Bill("Mohith",BB));
bills.push(new Bill("Rajesh",SG));
bills.push(new Bill("Abhinaav",SV));
bills.push(new Bill("Aparna",SG));
bills.push(new Bill("Abhinav",BB));
bills.push(new Bill("Vignesh",SG));
bills.push(new Bill("Abhinav",SG));
bills.push(new Bill("Advaith",SG));
bills.push(new Bill("George",SV));
bills.push(new Bill("Ahmed",SV));
bills.push(new Bill("Neerja",SV));
bills.push(new Bill("Ahmed",SV));
bills.push(new Bill("Akshaya",SV));
bills.push(new Bill("Suresh",SG));
bills.push(new Bill("Julia",SV));
bills.push(new Bill("Neerja",SV));
bills.push(new Bill("Ahmed",SG));
bills.push(new Bill("Srivatsan",SV));
bills.push(new Bill("Srivatsan",SG));
bills.push(new Bill("Vignesh",SV));
bills.push(new Bill("Ahmed",SV));
bills.push(new Bill("Radha",BB));
let itemlst=[];
//1
itemlst.push(
  [
    new Item("Carrots","Vegetables/Food",1.5,50),
    new Item("Soap","Toiletries",4,50,32),
    new Item("Tomatoes","Vegetables/Food",2,40),
    new Item("Bananas","Vegetables/Food",8,8),
    new Item("Socks","Footware/Apparel",3,56),
    new Item("Curd","Dairy/Food",0.5,32),
    new Item("Milk","Dairy/Food",1.5,24)
  ]
);
//2
itemlst.push(
  [
    new Item("Baked Beans","CannedFood",1,125),
    new Item("Chicken WIngs","Meat/Food",0.5,600),
    new Item("Cocoa Powder","Canned/Food",1,160),
    new Item("Capsicum","Vegetables/Food",0.8,180),
    new Item("Tie","Apparel",2,390),
    new Item("Clips","Household",0.5,32)
  ]
);
//3
itemlst.push(
  [
    new Item("Face Wash","Toiletries",1,89),
    new Item("Shampoo","Toiletries",1,140),
    new Item("Onions","Vegetables/Food",1,98),
    new Item("Bananas","Fruits/Food",4,8),
    new Item("Milk","Dairy/Food",1,24),
    new Item("Biscuits","Packed/Food",2,22),
    new Item("Maggi","Packed/Food",1,85),
    new Item("Horlicks","Packed/Food",1,270),
    new Item("Chips","Packed/Food",1,20),
    new Item("Chocolates","Packed/Food",4,10),
    new Item("Cereal","Packed/Food",1,220),
    new Item("Handwash","Toiletries",1,139),
    new Item("Air Freshner","Toiletries",2,70),
  ]
);
//4
itemlst.push(
  [
    new Item("Milk","Dairy/Food",2,24),
    new Item("Bread","Packed/Food",1,30),
    new Item("Eggs","Food",1,45),
  ]
);
//5
itemlst.push(
  [
    new Item("Trousers","Women/Apparel",2,870),
    new Item("Shirts","Women/Apparel",1,1350),
    new Item("Detergent","Household",0.5,270),
    new Item("Tee Shirts","Women/Apparel",4,220),
    new Item("Instant Noodles","Canned/Food",3,23)
  ]
);
//6
itemlst.push(
  [
    new Item("Batteries","Utilities",6,14),
    new Item("USB Cable","Electronics",1,85),
    new Item("Ball Pens","Stationery",5,12),
    new Item("Onions","Vegetables/Food",1.25,100)

  ]
);
//7
itemlst.push(
  [
    new Item("Bread","Packed/Food",1,30),
    new Item("Baiscuit","Packed/Food",3,22),
  ]
);
//8
itemlst.push(new Items(
["Trousers","Basa Fish","Boxers","Face Wash","Slippers"],
["Men/Apparel","Meat/Food","Men/Apparel","Toiletries","Footwear/Apparel"],
[2,1,4,1,1],
[950,350,160,72,170],
[1900,350,640,72,170]
)
)
//9
itemlst.push(new Items(
["Trousers","Basa Fish","Boxers","Face Wash","Slippers"],
["Men/Apparel","Meat/Food","Men/Apparel","Toiletries","Footwear/Apparel"],
[2,1,4,1,1],
[950,350,160,72,170],
[1900,350,640,72,170]
)
)


for (let i=0; i<30; i++){
  bills[i].items=itemlst[i];
}
