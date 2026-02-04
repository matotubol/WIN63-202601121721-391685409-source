package com.sulake.habbo.ui.widget.chooser.newfurni
{
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.utils.class_2262;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class NewFurniChooserTableObject implements ITableObject
   {
      
      private var var_1182:ChooserItem;
      
      public function NewFurniChooserTableObject(param1:ChooserItem)
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
         return var_1182.category + "-" + var_1182.id;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case NewFurniView.COLUMN_FURNI_NAME:
               return new TableCell(TableCell.var_101,var_1182.name,false,true);
            case NewFurniView.COLUMN_FURNI_OWNER:
               if(var_1182.owner == null || class_2262.isBuilderClubId(var_1182.id))
               {
                  return new TableCell(TableCell.var_101,"-");
               }
               return new TableCell(TableCell.var_101,var_1182.owner,false,true);
               break;
            case NewFurniView.COLUMN_ID:
               return new TableCell(TableCell.var_101,var_1182.id + "",false,true);
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

