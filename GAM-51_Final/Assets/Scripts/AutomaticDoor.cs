using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutomaticDoor : MonoBehaviour
{
    #region Variables
    public HingeJoint doorHinge;
    public JointSpring hingeSpring;
    public GameObject door;
    public float sensorLength;
    private float springValue = 200;
    private float springDamper = 50;
    private float springAngle;
    #endregion

    #region Methods
    private void Awake()
    {
        hingeSpring = doorHinge.spring;
        hingeSpring.spring = springValue;
        hingeSpring.damper = springDamper;
        doorHinge.useSpring = true;
    }

    private void Update()
    {
        Vector3 rayPosition = door.transform.position;
        rayPosition.y = 1;
        RaycastHit hit;
        Ray frontSensor = new Ray(rayPosition, transform.forward);
        Ray backSensor = new Ray(rayPosition, -transform.forward);

        if (Physics.Raycast(frontSensor, out hit, sensorLength))
        {
            if (hit.collider.tag == "Player")
            {
                StopAllCoroutines();
                hingeSpring.spring = springValue;
                hingeSpring.damper = springDamper;
                hingeSpring.targetPosition = -90.0f;
                doorHinge.spring = hingeSpring;
                StartCoroutine(CloseDoor());
            }
        }
        else if (Physics.Raycast(backSensor, out hit, sensorLength))
        {
            if (hit.collider.tag == "Player")
            {
                StopAllCoroutines();
                hingeSpring.spring = springValue;
                hingeSpring.damper = springDamper;
                hingeSpring.targetPosition = 90.0f;
                doorHinge.spring = hingeSpring;
                StartCoroutine(CloseDoor());
            }
        }
    }

    private IEnumerator CloseDoor()
    {
        yield return new WaitForSeconds(3.0f);
        hingeSpring.spring = springValue;
        hingeSpring.damper = springDamper;
        hingeSpring.targetPosition = 0.0f;
        doorHinge.spring = hingeSpring;
    }
    #endregion
}
