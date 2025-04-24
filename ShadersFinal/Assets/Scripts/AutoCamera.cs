using UnityEngine;

public class AutoCamera : MonoBehaviour
{
    public float speed = 10f;
    public float radius = 5f;

    void Update()
    {
        float angle = Time.time * speed;
        float x = Mathf.Cos(angle) * radius;
        float z = Mathf.Sin(angle) * radius;
        transform.position = new Vector3(x, transform.position.y, z);
        transform.LookAt(Vector3.zero);    }
}