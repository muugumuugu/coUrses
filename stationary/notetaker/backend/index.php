<html>
<head>
<link href="/styles/home.css" rel="stylesheet"></link><script src="/styles/syntaxhighlighter.js"></script>
<style>main{display:flex;flex-wrap:wrap;}input{background:transparent; border:none;}form{width:48%;}div{width:45%;padding:10px;border:dotted}textarea{width:100%;}</style>
<link rel="stylesheet" href="mukutex.css" crossorigin="anonymous">
<script  src="mukutex.js"></script>

<script>
let counter=0;
setInterval(function(){
document.getElementById("dat").value=document.getElementById('txt').value;
document.getElementById("fnt").value=document.getElementById('fn').value;
document.getElementsByTagName('form')[1].submit();
}, 60000); //AUTOSAVE
setInterval(function(){
let latex=document.getElementById("tempdiv").innerHTML;
if (latex){mukutexparse(latex)};
}, 4000); //parsemath









function mukutexparse(latexx){
	let latex=latexx;
	let regexp = /\$?\$(.*?)\$\$/g;
	let str=latex.replace(regexp,"#QQ");
	let temp=str.split("#QQ")
	let strs=[...latex.matchAll(regexp)]
	htmls=[temp[0]];
	for (let i=0; i<strs.length;i++){
		let str=strs[i][1]
		let html = mukutex.renderToString(str ,{
			throwOnError: false
		});
		htmls.push(html);
		htmls.push(temp[i+1])
	}
	let postlatex=htmls.join(' ');
	regexp = /```(\w+)/g;
	postcode=postlatex.replaceAll(regexp,"<pre><code lang=$1");
	regexp = /```<br>/g;
	postcodeclose=postcode.replaceAll(regexp,'</code></pre>');
	document.getElementById('tempdiv').innerHTML=postcodeclose;
	}
</script>
<script type = "text/javascript">
hljs.highlightAll();
window.onload=function(){
	ele=document.getElementsByTagName('textarea')[0]
	ele.focus();
	ele.setSelectionRange(ele.value.length, ele.value.length);
};
function sendit(e){
	if (e==undefined)
	{
	document.getElementById("dat").value=document.getElementsById('txt').value;
	document.getElementsByTagName('form')[0].submit();
	document.getElementsByTagName('textarea')[0].focus();
	}
	else{
		var charCode = (typeof e.which === "number") ? e.which : e.keyCode;
		if (charCode==13){sendit();}
	}
}
function fnameit(e){
document.getElementById("dat").value=document.getElementById('txt').value;
document.getElementById("fnt").value=document.getElementById('fn').value;
var charCode = (typeof e.which === "number") ? e.which : e.keyCode;
if (charCode==13){document.getElementsByTagName('form')[1].submit();}//save
}
function fdatait(e){
document.getElementById("dat").value=document.getElementById('txt').value;
var charCode = (typeof e.which === "number") ? e.which : e.keyCode;
if (charCode==13 ){document.getElementById('prv').submit();}//preview
}
document.onkeyup=function(e)
{
	document.getElementById("dat").value=document.getElementById('txt').value;
	document.getElementById("fnt").value=document.getElementById('fn').value;
	var key = e.which || e.keyCode
	if (e.ctrlKey && key==83 && e.altKey){
		document.getElementsByTagName('form')[1].submit();
	}
}
</script>
<body>
<main>
	<form id="prv" action="index.php" method="post">
		<input style="background:white" placeholder="draft.md" hidden value="<?php	if(isset ($_POST['fn'])){echo $_POST ['fn'];}else if(isset ($_POST['fnt'])){echo $_POST ['fnt'];}else {$dt=date("H-i-s_d-m-Y");echo "$dt.md";}?>" type="text" id="fnt" name="fnt" ></input>
		<textarea onkeyup="fdatait(event)" id="txt" name="md" rows="45" cols="100"  ><?php if(isset ($_POST['md'])){$str=$_POST ['md'];echo ($str);} else if(isset ($_POST['dat'])){$str=$_POST ['dat'];echo ($str);}?></textarea>
		<input  type="submit" value="" />


	</form>
	<span>&nbsp; &nbsp; </span>
	<div id="tempdiv">
		<?php
			if (isset($_POST['md'])){
			require "mukuMdParser.php";
			$str=$_POST ['md'];
			$mdparser= new mukuMdParser();
			echo $mdparser->text($str);
		}
			else{
			require "mukuMdParser.php";
			$str=$_POST ['dat'];
			$mdparser= new mukuMdParser();
			echo $mdparser->text($str);
			}
		?>
	</div>
<?php		if(isset ($_POST['fn'])){
				$fn= $_POST ['fn'];
				$str= $_POST ['dat'];
				file_put_contents($fn,$str);
			}
			else if(isset ($_POST['fnt'])){
				$fn= $_POST ['fnt'];
				$str= $_POST ['md'];
				file_put_contents($fn,$str);
			}

?>
</main>
<form action="index.php" method="post">
		<input onkeyup="fnameit(event)" style="background:white" placeholder="draft.md" value="<?php if(isset ($_POST['fn'])){echo $_POST ['fn'];}else if(isset ($_POST['fnt'])){echo $_POST ['fnt'];}else{$dt=date("H-i-s_d-m-Y");echo "$dt.md";}?>" type="text" id="fn" name="fn" ></input>
		<textarea id="dat" name="dat"  hidden><?php if(isset ($_POST['md'])){$str=$_POST ['md'];echo ($str);} else if(isset ($_POST['dat'])){$str=$_POST ['dat'];echo ($str);}?></textarea>
		<input style="background:white" type="submit" value="SAVE" name="submitForm" />
</form>
<script src="/styles/copybutton.js"></script>
<footer>
<a href="../">up 1 dir</a></footer>
</body>
</html>