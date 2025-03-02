import 'package:flutter/material.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class MedicalFacilityItem extends StatelessWidget{
  final bool isSelected;
  final bool isDisabled;
  final String address;
  final ValueChanged<bool>? onChanged;


  const MedicalFacilityItem({
    super.key,
    required this.isSelected,
    required this.isDisabled,
    required this.address,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
        if (onChanged != null) {
          onChanged!(!isSelected);
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? PrimaryColor.primary_05
              : PrimaryColor.primary_00,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? PrimaryColor.primary_05
                : PrimaryColor.primary_03,
            width: isSelected ? 2.0 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected
                  ? PrimaryColor.primary_00
                  : PrimaryColor.primary_03,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                address,
                style: (isSelected
                    ? TextStyleCustom.heading_3c
                    : TextStyleCustom.bodyLarge).copyWith(
                  color: isSelected
                      ? PrimaryColor.primary_00
                      : PrimaryColor.primary_03,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





//
// class MedicalFacilityItem extends StatefulWidget {
//   const MedicalFacilityItem({super.key, required this.address, required this.isSelected, required this.isDisabled});
//
//   final String address;
//   final bool isSelected;
//   final bool isDisabled;
//
//
//   @override
//   MedicalFacilityItemState createState() => MedicalFacilityItemState();
// }
//
// class MedicalFacilityItemState extends State<MedicalFacilityItem> {
//   // Khai báo trạng thái mặc định
//   MedicalFacilityState _state = MedicalFacilityState.defaultState;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _state = _state == MedicalFacilityState.defaultState
//               ? MedicalFacilityState.selectedState
//               : MedicalFacilityState.defaultState;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
//         decoration: BoxDecoration(
//           color: _state == MedicalFacilityState.selectedState
//               ? PrimaryColor.primary_05
//               : PrimaryColor.primary_00,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: _state == MedicalFacilityState.selectedState
//                 ? PrimaryColor.primary_05
//                 : PrimaryColor.primary_03,
//             width: _state == MedicalFacilityState.selectedState
//                 ? 2.0
//                 : 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.location_on,
//               color: _state == MedicalFacilityState.selectedState
//                   ? PrimaryColor.primary_00
//                   : PrimaryColor.primary_03,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 widget.address,
//                 style: (_state == MedicalFacilityState.selectedState
//                     ? TextStyleCustom.heading_3c
//                     : TextStyleCustom.bodyLarge).copyWith(
//                   color: _state == MedicalFacilityState.selectedState
//                       ? PrimaryColor.primary_00
//                       : PrimaryColor.primary_03,
//                 ),
//               ),
//             )
//
//           ],
//         ),
//
//       ),
//     );
//   }
// }

