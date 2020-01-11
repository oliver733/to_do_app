import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/colors.dart';
import 'package:to_do_list/data/bloc/bloc.dart';
import 'package:to_do_list/data/to_do_model.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  final Todo item;

  TodoTile({@required this.item});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.3,
      secondaryActions: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<TodoBloc>(context).add(DeleteTodo(item));
          },
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
      child: Container(
        height: 100, // TODO: make responsive
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          color: item.complete ? MyColors.lightGrey2 : MyColors.purpleBlue,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            // dense: true,
            title: Text(
              item.task,
              style: TextStyle(
                  color: Colors.white,
                  decoration: item.complete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            leading: Text(
              item.dateTime != null
                  ? "${DateFormat.jm().format(item.dateTime)}"
                  : "--:--",
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(
                  UpdateTodo(
                    item.copyWith(
                      complete: !item.complete,
                    ),
                  ),
                );
              },
              icon: Icon(
                  item.complete
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// return Slidable(
//           actionPane: SlidableBehindActionPane(),
//           actionExtentRatio: 0.3,
//           actions: [
//             IconSlideAction(
//                 foregroundColor: Colors.white,
//                 caption: 'Unfriend',
//                 color: Colors.red[400],
//                 icon: Icons.close,
//                 onTap: () async {
//                   try {
//                     await CloudFunctionsService()
//                         .unfriendUser(partnerId: partnerId);
//                   } catch (e) {
//                     print(e);
//                   }
//                 })
//           ],
//           secondaryActions: isLinked
//               ? [
//                   IconSlideAction(
//                       foregroundColor: Colors.white,
//                       caption: 'Unlink',
//                       color: Colors.blue[200],
//                       icon: Icons.link_off,
//                       onTap: () async {
//                         try {
//                           await CloudFunctionsService()
//                               .unlinkUser(partnerId: partnerId);
//                         } catch (e) {
//                           print(e);
//                         }
//                       })
//                 ]
//               : [
//                   IconSlideAction(
//                       foregroundColor: Colors.white,
//                       caption: 'Link',
//                       color: Colors.blue[400],
//                       icon: Icons.link,
//                       onTap: () async {
//                         if (moreThan15Linked) {
//                           _scaffoldKey.currentState.showSnackBar(SnackBar(
//                               content: new Text(
//                                   "Limit of 15 linked users reached.")));
//                         } else {
//                           try {
//                             await CloudFunctionsService()
//                                 .linkUser(partnerId: partnerId);
//                           } catch (e) {
//                             print(e);
//                           }
//                         }
//                       }),
//                 ],
//           key: Key(partnerId),
//           child: ChatTile(
//             isClose: isLinked,
//             partnerId: partnerId,
//           ),
//         );
