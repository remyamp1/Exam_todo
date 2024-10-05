import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ToDOList extends StatefulWidget {
  const ToDOList({super.key});

  @override
  State<ToDOList> createState() => _ToDOListState();
}

class _ToDOListState extends State<ToDOList> {
  List <Map<String,dynamic>> _todoitems=[];
  Color _selecteColor= Colors.pink;
  List <Color> _coloritems =[
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.green
  ];
  

  @override
void initState(){
  super.initState();
  _loadtoDoitems();
}

_loadtoDoitems() async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  List<String>? tasks=prefs.getStringList('todoitems');
   List<String>? colors=prefs.getStringList('todoitems');{
    if(tasks != null && colors != null){
      return{
        setState(() {
          _todoitems=List.generate(tasks.length, (index){
            return{
                'task':tasks[index],
            'color':Color(int.parse(colors[index]))
            };
          
          
         } );
        }),
      };
      
    }
    catct (e){
      print("Loading error pick:$e");
    }
   }

}

_savetodoitems()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  List<String> tasks=_todoitems.map((item)=>item['task'] as String).toList();
  List<String> colors=_todoitems.map((item){
    final Color colors=item['color'] as Color;{
      return colors.value.length
    }
    } ).toList();
await tasks=prefs.getStringList('todoitems':tasks);
await colors=prefs.getStringList('todoitems':colors);

  }
  

}

void _addtodoitems(String task){
  if (task.isNotEmpty){
    setState(() {
     _addtodoitems(task);  
    });
    _savetodoitems();
  }

 _promttodoitems() async{
  String newTask="";
  showModalBottomSheet(context: (context, index)
   builder:(BuildContext context){
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(decoration: InputDecoration(border: OutlineInputBorder(),
          
          ),
          autofocus: true,
          onChanged: (val){
            newTask: val;
          },
        ),
       SizedBox(height: 10,),
       Text('pick a task color'),
       SizedBox(height: 100,
       child: ListView.separated( separatorBuilder: (context,index){
        
        {
          SizedBox(width: 10);
        };
       },
scrollDirection: Axis.horizontal,
       itemCount:_todoitems.length,
       itemBuilder: (context,index){
        return GestureDetector(
          onTap: () {
            setState(() {
              if( _addtodoitems.(newTask));
            });
          },
        );
        
       }),
       ),
       TextButton(onPressed: (){
        setState(() {
          _selecteColor=_coloritems.length;
        });
       }, child: Text("add"))
        ],
      ),
    );

   });

  }
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
        Text("TO-DO List"),
      ),
      body: ListView.builder(itemBuilder: (context,index){
  Dismissible(key: Key(_todoitems.length),
  onDismissed: (direction) {
   _todoitems=_todoitems[index]['task'];
  },
  
  
   child: Icon(Icons.delete));
   Container(
decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
color: Colors.red,
),
    
   );

   
      }), 
      floatingActionButton: FloatingActionButton(onPressed: _loadtoDoitems,
      child: Text("Add")),
      
    );
  }
  