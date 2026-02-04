package com.sulake.habbo.ui.widget.chooser.newusers
{
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class NewUsersChooserTableObject implements ITableObject
   {
      
      private var var_1182:ChooserItem;
      
      public function NewUsersChooserTableObject(param1:ChooserItem)
      {
         super();
         var_1182 = param1;
      }
      
      public function get chooserItem() : ChooserItem
      {
         return var_1182;
      }
      
      public function get identifier() : String
      {
         return var_1182.type + "-" + var_1182.id;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case NewUsersView.COLUMN_USER_NAME:
               return new TableCell(TableCell.var_101,var_1182.name,false,true);
            case NewUsersView.COLUMN_TYPE:
               return new TableCell(TableCell.var_101,"${new_user_chooser.usertype." + var_1182.type + "}");
            default:
               return null;
         }
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return false;
      }
   }
}

