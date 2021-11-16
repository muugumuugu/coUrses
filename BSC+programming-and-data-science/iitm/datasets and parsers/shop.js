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
  categorycount(){
  let temp={};
    for (let i=0; i<this.items.length;i++){
      if(temp[this.items[i].cat])temp[this.items[i].cat]+=this.items[i].qt;
      else temp[this.items[i].cat]=this.items[i].qt;

    }
  return temp;
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
[950,350,160,72,170]
)
)
//9
itemlst.push(new Items(
["Mosquito Coil","Bananas","Ball Pens","Paper Clips"],
["Household","Fruits/Food","Stationery","Stationery"],
[2,6,4,1],
[24,5,12,60]
)
)
//10
itemlst.push(new Items(
["Bread","Biscuits"],
["Packed/Food","Packed/Food"],
[1,3],
[30,22]
)
)
//11
itemlst.push(new Items(
["Lindt","Socks","Spring Onions","Lettuce","Cookies"],
["Chocolate/Food","Footwear/Apparel","Vegetables/Food","Vegetables/Food","Snacks/Food"],
[1,1,0.5,0.6,2 ],
[125,120,220,150,75]
)
)
//12
itemlst.push(new Items(
["Phone Charger","Razor Blades","Razor","Shaving Lotion","Earphones","Pencils "],
["Utilities","Grooming","Grooming","Grooming","Electronics","Stationery"],
[1,1,1,0.8,1,3 ],
[230,12,45,180,210,5]
)
)
//13
itemlst.push(new Items(
["Chocolates","Cereal","Bananas","Tomatoes","Curd","Milk","Horlicks","Plates","Eggs "],
["Packed/Food","Packed/Food","Fruits/Food","Vegetables/Food","Dairy/Food","Dairy/Food","Packed/Food","Household","Food"],
[1,1,6,1,1,2,1,4,1 ],
[10,220,8,40,32,24,270,45,45]
)
)
//14
itemlst.push(new Items(
["Shoes","Polish","Socks "],
["Footwear/Apparel","Footwear/Apparel","Footwear/Apparel"],
[1,1,2 ],
[2700,120,120]
)
)
//15
itemlst.push(new Items(
["Keyboard","Mouse "],
["Electronics","Electronics"],
[1,1 ],
[780,320]
)
)
//16
itemlst.push(new Items(
["Cereal","Milk","Cupcakes","Chocolates"],
["Packed/Food","Dairy/Food","Packed/Food","Packed/Food"],
[1,1,1,1],
[220,24,25,10]
)
)
//17
itemlst.push(new Items(
["Broccoli","Chicken Legs","Basa Fish","Lettuce","Eggs "],
["Vegetables/Food","Meat/Food","Meat/Food","Vegetables/Food","Meat/Food"],
[0.5,0.5,1,0.8,12 ],
[120,320,350,150,9 ]
)
)
//18
itemlst.push(new Items(
["Pencils","Notebooks","Geometry Box","Graph Book "],
["Stationery","Stationery","Stationery","Stationery"],
[2,4,1,1 ],
[5,20,72,25 ]
)
)
//19
itemlst.push(new Items(
["Tomatoes","Curd","Cupcakes","Carrots","Beans","Onions","Turmeric","Ghee "],
["Vegetables/Food","Dairy/Food","Packed/Food","Vegetables/Food","Vegetables/Food","Vegetables/Food","Packed/Food","Packed/Food"],
[1,1,2,1.5,1,0.5,1,1 ],
[40,32,25,50,45,98,82,230 ]
)
)
//20
itemlst.push(new Items(
["Batteries","Tomatoes","Spinach","Bananas","Mosquito coils","Guava","Potato "],
["Utilities","Vegetables/Food","Vegetables/Food","Fruits/Food","Household","Fruits/Food","Vegetables/Food"],
[2,1.5,1,4,1,0.4,1.5 ],
[14,80,15,5,24,120,40 ]
)
)
//21
itemlst.push(new Items(
["Tomatoes","Curd","Cupcakes","Carrots","Onions","Handwash ","Bananas","Eggs"],
["Vegetables/Food","Dairy/Food","Packed/Food","Vegetables/Food","Vegetables/Food","Toiletries","Fruits/Food","Food"],
[2,2,3,0.5,1,1,12,1],
[40,32,25,50,98,139,8,45]
)
)
//22
itemlst.push(new Items(
["Carrots","Horlicks","Chips","Kajal "],
["Milk Vegetables/Food","Packed/Food","Packed/Food","Cosmetics","Dairy/Food"],
[1,1,1,1,3],
[50,270,20,180,24]
)
)
//23
itemlst.push(new Items(
["Curd","Butter","Milk "],
["Dairy/Food","Dairy/Food","Dairy/Food "],
[0.5,0.2,2 ],
[32,320,24 ]
)
)
//24
itemlst.push(new Items(
["Carrots","Bananas","Curd","Milk","Cereal","Maggi "],
["Vegetables/Food","Fruits/Food","Dairy/Food","Dairy/Food","Packed/Food","Packed/Food "],
[1.5,12,3,4,2,1 ],
[50,8,32,24,220,85 ]
)
)
//25
itemlst.push(new Items(
["Earphones","Phone cover","Dongle","A4 sheets","Ball Pens "],
["Electronics","Accessories","Electronics","Stationery","Stationery "],
[1,1,1,200,2 ],
[210,140,790,1,12 ]
)
)
//26
itemlst.push(new Items(
["Beans","Bread","Onions","Bananas","Curd","Milk "],
["Vegetables/Food","Packed/Food","Vegetables/Food","Fruits/Food","Dairy/Food","Dairy/Food "],
[1,1,0.5,6,1,3 ],
[45,30,98,8,32,24]
)
)
//27
itemlst.push(new Items(
["Broom","Dustpan","Floor Cleaner","Tissue Paper"],
["Household","Household","Household","Household"],
[1,1,1,2],
[70,45,125,50 ]
)
)
//28
itemlst.push(new Items(
["Milk","Chips "],
["Dairy/Food","Packed/Food"],
[3,1] ,
[24,20 ]
)
)
//29
itemlst.push(new Items(
["Face Wash","Shampoo","Maggi","Chips","Chocolates","Air Freshener "],
["Toiletries","Toiletries","Packed/Food","Packed/Food","Packed/Food","Toiletries"],
[1,1,1,1,4,2 ],
[89,140,85,20,10,70 ]
)
)
//30
itemlst.push(new Items(
["Chocolates","Curd","Bananas "],
["Packed/Food","Dairy/Food","Fruits/Food"],
[1,2,4 ],
[10,32,8]
)
)































for (let i=0; i<30; i++){
  bills[i].items=itemlst[i];
}
